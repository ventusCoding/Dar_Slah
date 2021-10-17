import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_sllah/classes/comment.dart';
import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/classes/includes.dart';
import 'package:dar_sllah/classes/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DishProvider with ChangeNotifier {
  String path;
  String idSelected;

  List<Dish> _dishes = [
    // Dish(
    //   id: 'd1',
    //   name: 'couscous',
    //   description: 'Le lorem ipsum est, en imprimerie',
    //   image:
    //       'https://firebasestorage.googleapis.com/v0/b/decori-38bc0.appspot.com/o/dar%20slahh%2F2.png?alt=media&token=d6a2f03a-e07f-41cd-8ec1-c2b7cc143764',
    //   price: 29.99,
    //   quantity: 0,
    //   includes: [
    //     Includes(
    //       id: 'i1',
    //       name: 'Coca Cola',
    //       price: 0.5,
    //       quantity: 0,
    //     )
    //   ],
    //   rate: 3.5,
    //   //location: Location(39.5, 5.4),
    // ),
    // Dish(
    //   id: 'd2',
    //   name: 'Meatballs',
    //   description: 'Le lorem ipsum est, en imprimerie',
    //   image:
    //       'https://firebasestorage.googleapis.com/v0/b/decori-38bc0.appspot.com/o/dar%20slahh%2F3.png?alt=media&token=c4ac0334-1239-4726-b97b-5ffdfc25af50',
    //   price: 50,
    //   quantity: 0,
    //   includes: [
    //     Includes(
    //       id: 'i1',
    //       name: 'Fanta',
    //       price: 0.5,
    //       quantity: 0,
    //     ),
    //     Includes(
    //       id: 'i2',
    //       name: 'Coca Cola',
    //       price: 0.5,
    //       quantity: 0,
    //     ),
    //     Includes(
    //       id: 'i3',
    //       name: 'ketchup',
    //       price: 0.5,
    //       quantity: 0,
    //     ),
    //   ],
    //   rate: 3.5,
    //   //location: Location(39.5, 5.4),
    // ),
    // Dish(
    //   id: 'd3',
    //   name: 'couscous',
    //   description: 'Le lorem ipsum est, en imprimerie',
    //   image:
    //       'https://firebasestorage.googleapis.com/v0/b/decori-38bc0.appspot.com/o/dar%20slahh%2F4.png?alt=media&token=718a1c77-bc68-4cfc-a058-e4dcdd561305',
    //   price: 29.99,
    //   quantity: 0,
    //   includes: [
    //     Includes(
    //       id: 'i1',
    //       name: 'Coca Cola',
    //       price: 0.5,
    //       quantity: 0,
    //     )
    //   ],
    //   rate: 3.5,
    //   //location: Location(39.5, 5.4),
    // ),
    // Dish(
    //   id: 'd4',
    //   name: 'salade',
    //   description: 'Le lorem ipsum est, en imprimerie',
    //   image:
    //       'https://firebasestorage.googleapis.com/v0/b/decori-38bc0.appspot.com/o/dar%20slahh%2F5.png?alt=media&token=fc44b3b1-062c-4eda-a424-124514e302bb',
    //   price: 29.99,
    //   quantity: 0,
    //   includes: [
    //     Includes(
    //       id: 'i1',
    //       name: 'Coca Cola',
    //       price: 0.5,
    //       quantity: 0,
    //     ),
    //     Includes(
    //       id: 'i1',
    //       name: 'Apla',
    //       price: 0.5,
    //       quantity: 0,
    //     ),
    //   ],
    //   rate: 4,
    //   //location: Location(39.5, 5.4),
    // ),
  ];

  List<Dish> _packedDishes = [];

  List<Dish> get dishes {
    return [..._dishes];
  }

  void set setDishes(List<Dish> newdishes) {
    _dishes = newdishes;
  }

  List<Dish> get packedDishes {
    return [..._packedDishes];
  }

  void addPackedDishes(Dish dish) {
    _packedDishes.add(dish);
    notifyListeners();
  }

  void deletePackedDishes(String id) {
    _packedDishes.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  Dish packedFindById(String id) {
    return packedDishes.firstWhere((prod) => prod.id == id);
  }

  int get dishesLength {
    return dishes.length;
  }

  Dish findById(String id) {
    return _dishes.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchData(String path) async {
    List<Includes> includesList = new List();
    _dishes.clear();

    FirebaseFirestore.instance
        .collection(path)
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) async {
              Dish dish = new Dish(
                id: element['id'],
                description: element['description'],
                image: element['image'],
                name: element['name'],
                price: double.parse(element['price'].toString()),
                rate: double.parse(element['rate'].toString()),
                quantity: 1,
                total: double.parse(element['price'].toString()),
              );

              await FirebaseFirestore.instance
                  .collection('$path/${dish.id}/includes')
                  .get()
                  .then((snapshot) => snapshot.docs.forEach((element) {
                        Includes includes = new Includes(
                          id: element['id'],
                          name: element['name'],
                          price: double.parse(element['price'].toString()),
                          image: element['image'],
                          quantity: 0,
                        );
                        includesList.add(includes);
                      }))
                  .then((_) {
                dish.includes = new List();

                for (var elem in includesList) {
                  dish.includes.add(elem);
                }

                includesList.clear();

                _dishes.add(dish);
                notifyListeners();
              });
            }));
  }

  void setPath(String pathString) {
    path = pathString;
  }

  String getPath() {
    return path;
  }

  void setIdSelected(String selectedId) {
    idSelected = selectedId;
  }

  String getIdSelected() {
    return idSelected;
  }
}

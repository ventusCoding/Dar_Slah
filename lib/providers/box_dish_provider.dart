import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/classes/includes.dart';
import 'package:dar_sllah/classes/overview_box.dart';
import 'package:flutter/material.dart';

class BoxDishProvider with ChangeNotifier {
  List<Dish> _boxDishes = [];

  List<Dish> get boxDishes {
    return [..._boxDishes];
  }

  int get boxDishesLength {
    return boxDishes.length;
  }

  Dish findById(String id) {
    return _boxDishes.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchData() async {
    List<Includes> includesList = new List();
    List<OverviewBox> overViewsList = new List();
    _boxDishes.clear();

    await FirebaseFirestore.instance
        .collection('box')
        .get()

        .then((snapshot) => snapshot.docs.forEach((element) async {
              Dish boxDish = new Dish(
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
                  .collection('box/${boxDish.id}/includes')
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
                boxDish.includes = new List();

                for (var elem in includesList) {
                  boxDish.includes.add(elem);
                }

                includesList.clear();
              });

              await FirebaseFirestore.instance
                  .collection('box/${boxDish.id}/overview')
                  .get()
                  .then((snapshot) => snapshot.docs.forEach((element) {
                        OverviewBox overView = new OverviewBox(
                          id: element['id'],
                          name: element['name'],
                          image: element['image'],
                        );
                        overViewsList.add(overView);
                      }))
                  .then((value) {
                boxDish.overviewList = new List();

                for (var elem in overViewsList) {
                  boxDish.overviewList.add(elem);
                }

                overViewsList.clear();

                _boxDishes.add(boxDish);
                notifyListeners();
              });
            }));
  }
}

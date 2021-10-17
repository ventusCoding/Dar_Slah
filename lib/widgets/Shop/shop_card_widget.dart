import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/classes/includes.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/screens/Shop/shop_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopCard extends StatelessWidget {
  String id;
  String name;
  String image;
  double rate;
  double price;
  int quantity;
  String description;
  List<Includes> includes;

  ShopCard({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.image,
    @required this.price,
    @required this.quantity,
    @required this.includes,
    @required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    final loadedDish =
        Provider.of<DishProvider>(context, listen: false).findById(id);

    return Center(
      child: GestureDetector(
        onTap: () {
          Provider.of<DishProvider>(context, listen: false).setIdSelected(id);

          Navigator.of(context).pushNamed(
            DetailedShopScreen.routeName,
            arguments: id,
          );
        },
        child: Card(
          margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(flex: 3, child: Image.network('$image')),
                Flexible(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$name',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              '$price DT',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 17),
                            )
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Text(
                              description.length < 40
                                  ? '$description'
                                  : '${description.substring(0, 50)} ...',
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextButton(
                                child: Text(
                                  'Learn more',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Provider.of<DishProvider>(context,
                                          listen: false)
                                      .setIdSelected(id);

                                  Navigator.of(context).pushNamed(
                                    DetailedShopScreen.routeName,
                                    arguments: id,
                                  );
                                },
                              ),
                              MaterialButton(
                                color: Theme.of(context).primaryColor,
                                shape: CircleBorder(),
                                elevation: 1,
                                onPressed: () {
                                  Scaffold.of(context).hideCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Added Item to  cart!'),
                                    duration: Duration(seconds: 2),
                                    action: SnackBarAction(
                                      label: 'UNDO',
                                      onPressed: () {
                                        // do something
                                      },
                                    ),
                                  ));

                                  final savedDish = new Dish(
                                    description: loadedDish.description,
                                    id: loadedDish.id +
                                        DateTime.now().toString(),
                                    image: loadedDish.image,
                                    name: loadedDish.name,
                                    price: loadedDish.price,
                                    quantity: 1,
                                    rate: loadedDish.rate,
                                    total: loadedDish.total,
                                  );

                                  savedDish.includes = new List();

                                  loadedDish.includes.forEach((element) {
                                    Includes includes = new Includes(
                                      id: element.id +
                                          DateTime.now().toString(),
                                      image: element.image,
                                      name: element.name,
                                      price: element.price,
                                      quantity: 0,
                                    );

                                    savedDish.includes.add(includes);
                                  });

                                  Provider.of<DishProvider>(context,
                                          listen: false)
                                      .addPackedDishes(savedDish);
                                },
                                child: Container(
                                    child: Icon(
                                  Icons.shopping_bag,
                                  color: Colors.white,
                                )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

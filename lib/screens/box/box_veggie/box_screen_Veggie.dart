import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/classes/includes.dart';
import 'package:dar_sllah/main.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/screens/box/box_veggie/box_veggie_detailed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoxScreenVeggie extends StatelessWidget {
  Dish veggieDish;

  BoxScreenVeggie({
    @required this.veggieDish,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return veggieDish.image == ""
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: [
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.75,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      image: DecorationImage(
                          image: AssetImage("assets/images/box_img1.png"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(75),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RaisedButton.icon(
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    label: Text(
                      'BACK',
                    ),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    color: Colors.transparent,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.1),
                    child: Center(
                      child: Image.asset(
                        "assets/images/dar_sllah_logo.png",
                        width: size.width * 0.75,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width,
                    margin: EdgeInsets.only(top: size.height * 0.1),
                    child: Center(
                      child: Text(
                        "Envie d'un déjeuner léger,sain\net équilibre",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 2,
                            fontSize: size.width * 0.040,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16, top: 16),
                        width: size.width * 0.75,
                        height: size.height * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "la Box",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${veggieDish.price} DT",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                "${veggieDish.name}",
                                style: TextStyle(
                                  fontSize: size.width * 0.125,
                                  color: HexColor('#468257'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 75),
                                child: Text(
                                  veggieDish.description.length < 40
                                      ? '${veggieDish.description}'
                                      : '${veggieDish.description.substring(0, 50)} ...',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      height: 2),
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 16),
                                        child: OutlineButton(
                                          child: new Text(
                                            "Take a look",
                                            style: TextStyle(
                                              color: HexColor('#468257'),
                                            ),
                                          ),
                                          borderSide: BorderSide(
                                            color: HexColor('#468257'),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                BoxDetailedVeggie.routeName);
                                          },
                                        ),
                                      ),
                                    ),
                                    ButtonWidget(
                                        loadedDish: veggieDish, quantity: 1),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(size.width * 0.60, size.height * 0.085),
                        child: Container(
                          width: size.width * 0.33,
                          child: veggieDish.image == ""
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Image.network(
                                  "${veggieDish.image}",
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
    @required this.loadedDish,
    @required int quantity,
  })  : _quantity = quantity,
        super(key: key);

  final Dish loadedDish;
  final int _quantity;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      minWidth: 40,
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
          id: loadedDish.id + DateTime.now().toString(),
          image: loadedDish.image,
          name: loadedDish.name,
          price: loadedDish.price,
          quantity: _quantity,
          rate: loadedDish.rate,
          total: loadedDish.total,
        );

        savedDish.includes = new List();

        loadedDish.includes.forEach((element) {
          Includes includes = new Includes(
            id: element.id + DateTime.now().toString(),
            image: element.image,
            name: element.name,
            price: element.price,
            quantity: element.quantity,
          );

          savedDish.includes.add(includes);
        });

        Provider.of<DishProvider>(context, listen: false)
            .addPackedDishes(savedDish);
      },
      color: HexColor('#468257'),
      textColor: Colors.white,
      child: Icon(
        Icons.shopping_bag,
      ),
      padding: EdgeInsets.all(8),
      shape: CircleBorder(),
    );
  }
}

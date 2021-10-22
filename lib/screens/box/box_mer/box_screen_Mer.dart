import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/classes/includes.dart';
import 'package:dar_sllah/main.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/screens/box/box_mer/box_mer_detailed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoxScreenMer extends StatelessWidget {
  Dish merDish;

  BoxScreenMer({
    @required this.merDish,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return merDish.image == ""
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
                          image: AssetImage("assets/images/box_img2.png"),
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
                        margin: EdgeInsets.only(
                            left: size.width / 26, top: size.height / 50),
                        width: size.width * 0.75,
                        height: size.height * 0.34,
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
                                        fontSize: size.width / 27,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${merDish.price} DT",
                                    style: TextStyle(
                                        fontSize: size.width / 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                "${merDish.name}",
                                style: TextStyle(
                                  fontSize: size.width * 0.12,
                                  color: HexColor('#AFCEE5'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 75),
                                child: Text(
                                  merDish.description.length < 40
                                      ? '${merDish.description}'
                                      : '${merDish.description.substring(0, 50)} ...',
                                  style: TextStyle(
                                      fontSize: size.width / 29,
                                      color: Colors.grey,
                                      height: 1.5),
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
                                        height: size.width / 11,
                                        margin: EdgeInsets.only(
                                            right: 16, top: size.width / 70),
                                        child: OutlineButton(
                                          child: new Text(
                                            "Take a look",
                                            style: TextStyle(
                                              color: HexColor('#AFCEE5'),
                                            ),
                                          ),
                                          borderSide: BorderSide(
                                            color: HexColor('#AFCEE5'),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                BoxDetailedMer.routeName);
                                          },
                                        ),
                                      ),
                                    ),
                                    ButtonWidget(
                                        loadedDish: merDish, quantity: 1),
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
                          child: Image.network(
                            "${merDish.image}",
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
      color: HexColor('#AFCEE5'),
      textColor: Colors.white,
      child: Icon(
        Icons.shopping_bag,
      ),
      padding: EdgeInsets.all(8),
      shape: CircleBorder(),
    );
  }
}

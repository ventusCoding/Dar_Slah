import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/classes/includes.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/screens/Shop/shop_detail_screen.dart';
import 'package:dar_sllah/widgets/Home%20Main%20Widgets/learn_more_and_sac_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayDishesCardWidget extends StatelessWidget {
  String id;
  String name;
  String image;
  double rate;
  double price;
  int quantity;
  String description;
  List<Includes> includes;

  TodayDishesCardWidget({
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

    return GestureDetector(
      onTap: () {
        Provider.of<DishProvider>(context, listen: false).setIdSelected(id);
        Navigator.of(context).pushNamed(
          DetailedShopScreen.routeName,
          arguments: id,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              height: MediaQuery.of(context).size.height / 2.05, //change this
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 8,
                ),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height /
                            6.5, // change this
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '$name',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize:
                                    MediaQuery.of(context).size.width / 28,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '$price DT',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize:
                                    MediaQuery.of(context).size.width / 23,
                                color: const Color(0xff468257),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          description.length < 40
                              ? '$description'
                              : '${description.substring(0, 50)} ...',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: MediaQuery.of(context).size.width / 31.5,
                            color: const Color(0xffa7aba9),
                            height: 1.5,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                              child: Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.width / 31.5),
                                child: Text(
                                  'Learn more',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 29,
                                    color: Theme.of(context).primaryColor,
                                  ),
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
                                  id: loadedDish.id + DateTime.now().toString(),
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
                                    id: element.id + DateTime.now().toString(),
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
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              width: MediaQuery.of(context).size.width / 2.1,
              height: MediaQuery.of(context).size.width / 2.1,
              child: Image.network('$image'),
            ),
          ],
        ),
      ),
    );
  }
}

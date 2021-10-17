import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/classes/includes.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/screens/Shop/shop_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LearnMoreAndSacBtnWidget extends StatelessWidget {
  String id;

  LearnMoreAndSacBtnWidget({
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final loadedDish =
        Provider.of<DishProvider>(context, listen: false).findById(id);

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<DishProvider>(context,listen: false).setIdSelected(id);
              
              Navigator.of(context).pushNamed(
                DetailedShopScreen.routeName,
                arguments: id,
              );
            },
            child: Container(
              alignment: Alignment.bottomLeft,
              height: double.infinity,
              padding: EdgeInsets.only(left: 10, bottom: 30, top: 10),
              child: Text(
                'Learn More',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 13,
                  color: const Color(0xfffbce01),
                  fontWeight: FontWeight.w600,
                  height: 2.6923076923076925,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignment: Alignment.bottomRight,
            width: 40,
            height: double.infinity,
            child: GestureDetector(
              onTap: () {
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

                // if (Provider.of<DishProvider>(context, listen: false)
                //         .packedDishes
                //         .length ==
                //     0) {
                //   Provider.of<DishProvider>(context, listen: false)
                //       .addPackedDishes(loadedDish);
                //   return;
                // }

                // var containDish = false;

                // Provider.of<DishProvider>(context, listen: false)
                //     .packedDishes
                //     .forEach((element) {
                //   if (element.id == loadedDish.id) {
                //     containDish = true;
                //   }
                // });

                // if (containDish == true) {
                //   Provider.of<DishProvider>(context, listen: false)
                //       .packedFindById(loadedDish.id)
                //       .quantity++;
                //   return;
                // }

                // Provider.of<DishProvider>(context, listen: false)
                //     .addPackedDishes(loadedDish);

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

                Provider.of<DishProvider>(context, listen: false)
                    .addPackedDishes(savedDish);
              },
              child: Image.asset("assets/images/sac_btn.png"),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:dar_sllah/main.dart';
import 'package:dar_sllah/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:provider/provider.dart';

import 'bag_card_widget.dart';

class BagWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedPackedDishes = Provider.of<DishProvider>(context).packedDishes;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            height: 390,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => BagCardWidget(
                id: loadedPackedDishes[i].id,
                image: loadedPackedDishes[i].image,
                name: loadedPackedDishes[i].name,
                total: loadedPackedDishes[i].total,
                quantity: loadedPackedDishes[i].quantity,
              ),
              itemCount: loadedPackedDishes.length,
            ),
          ),
          SizedBox(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 4,
                  spreadRadius: -2,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30.0),
                topRight: const Radius.circular(30.0),
              ),
              child: Container(
                height: 200.0,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 14,
                                color: const Color(0xff707070),
                                height: 2.0714285714285716,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              ':',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 14,
                                color: const Color(0xff707070),
                                height: 2.0714285714285716,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              '30 DT',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 14,
                                color: const Color(0xff707070),
                                height: 2.0714285714285716,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 14,
                                color: const Color(0xff707070),
                                height: 2.0714285714285716,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              ':',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 14,
                                color: const Color(0xff707070),
                                height: 2.0714285714285716,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              '30 DT',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 14,
                                color: const Color(0xff707070),
                                height: 2.0714285714285716,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: 1,
                        color: HexColor("#707070"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 20,
                                color: const Color(0xff707070),
                                fontWeight: FontWeight.w600,
                                height: 1.8181818181818181,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              '30 DT',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 20,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                                height: 2,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PaymentScreen.routeName);
                        },
                        child: SizedBox(
                          width: 270,
                          height: 70,
                          child: Image.asset("assets/images/check_out_btn.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
              width: 300,
              height: 390, //change this
              child: Padding(
                padding: EdgeInsets.only(
                  top: 100,
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
                        height: 120, // change this
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
                                fontSize: 15,
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
                                fontSize: 18,
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
                            fontSize: 13,
                            color: const Color(0xffa7aba9),
                            height: 2.6923076923076925,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      LearnMoreAndSacBtnWidget(
                        id: id,
                      )
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
              width: 200,
              height: 200,
              child: Image.network('$image'),
            ),
          ],
        ),
      ),
    );
  }
}

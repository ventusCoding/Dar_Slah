import 'dart:ffi';

import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/widgets/Home%20Main%20Widgets/search_bar_widget.dart';
import 'package:dar_sllah/widgets/Shop/shop_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool _isLoading = true;
  var _isInit = true;
  List<Dish> dishesForDisplay;

  @override
  void initState() {
    Provider.of<DishProvider>(context, listen: false).setPath("Shop");

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<DishProvider>(context).fetchData("Shop").whenComplete(() {
        setState(() {
          _isLoading = !_isLoading;
        });
      });
    }
    dishesForDisplay = Provider.of<DishProvider>(context, listen: false).dishes;
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dishesData = Provider.of<DishProvider>(context, listen: false);
    final dishes = dishesData.dishes;

    double heigthCard = 190.0 * dishesForDisplay.length;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        height: 200,
                        width: 250,
                        child: Image.asset("assets/images/logo_shop.png"),
                      ),
                    ),
                    SearchBarWidget(dishes, (list) {
                      setState(() {
                        dishesForDisplay = list;
                        print("$heigthCard");
                      });
                    }),
                    Container(
                      height: heigthCard,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, i) => ShopCard(
                          id: dishesForDisplay[i].id,
                          description: dishesForDisplay[i].description,
                          image: dishesForDisplay[i].image,
                          includes: [],
                          name: dishesForDisplay[i].name,
                          price: dishesForDisplay[i].price,
                          quantity: dishesForDisplay[i].quantity,
                          rate: dishesForDisplay[i].rate,
                        ),
                        itemCount: dishesForDisplay.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

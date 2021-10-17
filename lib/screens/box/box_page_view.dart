import 'dart:async';

import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/providers/box_dish_provider.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/screens/box/box_terre/box_screen_Terre.dart';
import 'package:dar_sllah/widgets/OnBoarding/Dot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'box_mer/box_screen_Mer.dart';
import 'box_veggie/box_screen_Veggie.dart';

class BoxPageViewScreen extends StatefulWidget {
  static String routeName = "BoxPageViewScreen";

  @override
  _BoxPageViewScreenState createState() => _BoxPageViewScreenState();
}

class _BoxPageViewScreenState extends State<BoxPageViewScreen> {
  bool _isLoading = true;
  int _currentIndex = 0;
  var _isInit = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<BoxDishProvider>(context).fetchData().whenComplete(() {
        // Timer(Duration(seconds: 1), () {
        //   setState(() {
        //     _isLoading = !_isLoading;
        //   });
        // });

        setState(() {
          _isLoading = !_isLoading;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    Dish terreDish = new Dish(
        id: '',
        name: '',
        description: '',
        image: '',
        price: 0,
        quantity: 0,
        rate: 0,
        total: 0);
    Dish merDish = new Dish(
        id: '',
        name: '',
        description: '',
        image: '',
        price: 0,
        quantity: 0,
        rate: 0,
        total: 0);

    Dish veggieDish = new Dish(
        id: '',
        name: '',
        description: '',
        image: '',
        price: 0,
        quantity: 0,
        rate: 0,
        total: 0);

    if (!_isLoading) {
      try {
        terreDish = Provider.of<BoxDishProvider>(context, listen: false)
            .findById("Terre");
        merDish = Provider.of<BoxDishProvider>(context, listen: false)
            .findById("Mer");

        veggieDish = Provider.of<BoxDishProvider>(context, listen: false)
            .findById("Veggie");
      } catch (Exeption) {}
    }

    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.9,
                      margin: EdgeInsets.only(top: statusBarHeight),
                      child: PageView(
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        children: [
                          BoxScreenTerre(
                            terreDish: terreDish,
                          ),
                          BoxScreenMer(
                            merDish: merDish,
                          ),
                          BoxScreenVeggie(
                            veggieDish: veggieDish,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: 10,
                      ),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: EdgeInsets.only(left: 5),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _currentIndex == index
                                  ? _currentIndex == 1 ? HexColor("#AFCEE5") : HexColor("#468257")
                                  : HexColor("#EFEFEF"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}

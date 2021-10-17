import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/widgets/Bag/bag_widget.dart';
import 'package:dar_sllah/widgets/Bag/empty_bag_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedDishes = Provider.of<DishProvider>(context).packedDishes;

    return Scaffold(
      backgroundColor: Colors.white,
      body: loadedDishes.length == 0 ? EmptyBagWidget() : BagWidget(),
    );
  }
}

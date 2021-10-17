import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatelessWidget {
  List<Dish> dishes;

  final returnedDishes;

  SearchBarWidget(this.dishes, this.returnedDishes);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 4.0), //(x,y)
            blurRadius: 10.0,
            spreadRadius: -5,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          29.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: TextField(
          onChanged: (text) {
            text = text.toLowerCase();

            dishes = Provider.of<DishProvider>(context, listen: false)
                .dishes
                .where((element) {
              var name = element.name.toLowerCase();
              return name.contains(text);
            }).toList();

            returnedDishes(dishes);
          },
          decoration: InputDecoration(
            hintText: "Search",
            icon: Icon(
              Icons.search,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

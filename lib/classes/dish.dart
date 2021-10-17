import 'package:dar_sllah/classes/includes.dart';
import 'package:flutter/cupertino.dart';

import 'overview_box.dart';

class Dish {
  String id;
  String name;
  String image;
  double rate;
  double price;
  int quantity;
  String description;
  List<Includes> includes;
  double total;
  List<OverviewBox> overviewList;

  Dish({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.image,
    @required this.price,
    @required this.quantity,
    this.includes,
    @required this.rate,
    @required this.total,
    this.overviewList,
  });
}

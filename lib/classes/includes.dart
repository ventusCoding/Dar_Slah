import 'package:flutter/cupertino.dart';

class Includes {
  String id;
  String image;
  String name;
  double price;
  int quantity;

  Includes({
    @required this.id,
    @required this.image,
    @required this.name,
    @required this.price,
    this.quantity,
  });
}

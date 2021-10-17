import 'package:flutter/cupertino.dart';

class Comment {
  String id;
  String name;
  String description;
  String image;
  double rate;

  Comment({
    @required this.id,
    @required this.description,
    @required this.image,
    @required this.name,
    @required this.rate,
  });
}

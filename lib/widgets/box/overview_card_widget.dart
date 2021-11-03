import 'package:flutter/material.dart';

class OverViewCardWidget extends StatelessWidget {
  String id;
  String name;
  String image;

  OverViewCardWidget({
    @required this.name,
    @required this.image,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.width / 10,
          width: MediaQuery.of(context).size.height / 15,
          color: Colors.transparent,
          child: new Container(
              decoration: new BoxDecoration(
                border: Border.all(),
                color: Colors.white,
                borderRadius: new BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: new Center(
                child: Image.network("$image"),
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '$name',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: MediaQuery.of(context).size.width / 27,
            color: const Color(0xff000000),
          ),
          textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

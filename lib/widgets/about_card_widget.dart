import 'package:flutter/material.dart';

class AboutCardWidget extends StatelessWidget {
  String image;
  String name;
  String description;

  AboutCardWidget(this.image, this.name, this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image.asset(image),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w500,
                  height: 2.1666666666666665,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 12,
                  color: const Color(0xff8d8d8d),
                  height: 2.4166666666666665,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

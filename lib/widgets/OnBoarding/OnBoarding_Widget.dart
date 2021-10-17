import 'package:flutter/material.dart';


class OnBoardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String images;

  OnBoardingWidget(this.title, this.description, this.images);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
          ),
          Container(
            width: double.infinity,
            child: Image.asset(
              images,
              width: 350,
              height: 350,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 30,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w700,
              height: 1.6388888888888888,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 5),
            child: Text(
              description,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 16,
                color: const Color(0xff949494),
                height: 1.875,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

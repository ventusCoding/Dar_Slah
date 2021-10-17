import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class RateUsDialogCardWidget extends StatefulWidget {
  @override
  _RateUsDialogCardWidgetState createState() => _RateUsDialogCardWidgetState();
}

class _RateUsDialogCardWidgetState extends State<RateUsDialogCardWidget> {
  int dialogShowInt;

  void customLunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double _rating;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: EdgeInsets.only(right: 20, top: 20),
            alignment: Alignment.centerRight,
            child: Image.asset("assets/images/close.png"),
          ),
        ),
        SizedBox(
          height: 30,
          width: double.infinity,
        ),
        SizedBox(
          height: 100,
          width: 200,
          child: Image.asset("assets/images/logo_green.png"),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 251.0,
          child: Text(
            'Your Opinion Matter \nTo us',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 24,
              color: const Color(0xff000000),
              height: 1.75,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        RatingBar(
          onRatingChanged: (rating) => setState(() => _rating = rating),
          filledIcon: Icons.star,
          emptyIcon: Icons.star_border,
          halfFilledIcon: Icons.star_half,
          isHalfAllowed: true,
          filledColor: Theme.of(context).primaryColor,
          emptyColor: Theme.of(context).primaryColor,
          halfFilledColor: Theme.of(context).primaryColor,
          size: size.width * 0.08,
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: RaisedButton(
            child: Text(
              'Sumbit Your Rate',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            onPressed: () async {
              if (Platform.isAndroid) {
                customLunch("https://play.google.com/store/apps/details?id=" +
                    'com.CreativeSpace.GeoSave');
              } else if (Platform.isIOS) {
                customLunch(
                    "market://details?id=" + 'com.CreativeSpace.GeoSave');
              }

              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.setInt('dialogShowInt', 1);
            },
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

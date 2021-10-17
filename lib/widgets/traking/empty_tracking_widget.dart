import 'package:dar_sllah/screens/bottom_tab_screen.dart';
import 'package:flutter/material.dart';

class EmptyTrackingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 30),
          width: 170,
          height: 170,
          child: Image.asset("assets/images/no_tracking_image.png"),
        ),
        Text(
          'No Order To Track',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 29,
            color: const Color(0xff313131),
            height: 1.7241379310344827,
          ),
          textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
          textAlign: TextAlign.center,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
          child: Text(
            'We can guarantee you something once you try our food your bag will never stay empty again',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 14,
              color: const Color(0xffa7aba9),
              height: 2.5,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 200,
          height: 50,
          child: RaisedButton(
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BottomTabScreen(),
                ),
              );
            },
            color: Colors.white,
            textColor: Theme.of(context).primaryColor,
            child: Text(
              'Try Our Food',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }
}

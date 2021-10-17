import 'package:flutter/material.dart';

class TrakingCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: 200,
          height: 270, //change this
          child: Padding(
            padding: EdgeInsets.only(
              top: 30,
            ),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 100, // change this
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Your Order',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 17,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 17,
                          color: const Color(0xff2e7342),
                        ),
                        children: [
                          TextSpan(
                            text: 'Num',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: ':4859#',
                            style: TextStyle(
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                    width: double.infinity,
                    height: 40,
                    child: RaisedButton(
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      onPressed: () {},
                      color: Colors.white,
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Track Your Order',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: 100,
          height: 100,
          child: Image.asset("assets/images/packkage_dar_sllah.png"),
        ),
      ],
    );
  }
}

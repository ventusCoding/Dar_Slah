import 'package:dar_sllah/main.dart';
import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  int _currentIndex;
  int _onBoardingContentLength;

  Dot(this._currentIndex, this._onBoardingContentLength);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _onBoardingContentLength,
          (index) => Container(
            margin: EdgeInsets.only(left: 5),
            height: MediaQuery.of(context).size.width / 40,
            width:  MediaQuery.of(context).size.width / 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _currentIndex == index
                  ? Theme.of(context).primaryColor
                  : HexColor("#EFEFEF"),
            ),
          ),
        ),
      ),
    );
  }
}

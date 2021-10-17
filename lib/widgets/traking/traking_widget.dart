import 'package:dar_sllah/widgets/traking/traking_card_widget.dart';
import 'package:flutter/material.dart';

class TrakingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
          child: Column(
        children: [
          SizedBox(height: 50,),
          Text(
            'Track Your Products\nIn Real Time ',
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
          SizedBox(height: 10,),
          TrakingCardWidget(),
        ],
      ),
    );
  }
}

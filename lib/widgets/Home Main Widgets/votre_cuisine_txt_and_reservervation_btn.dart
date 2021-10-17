import 'package:dar_sllah/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VotreCuisineTxtAndReservationBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var authBloc = Provider.of<AuthBloc>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 50,
            left: 20,
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 28,
                color: const Color(0xff468257),
                height: 1.8214285714285714,
              ),
              children: [
                TextSpan(
                  text: 'Votre ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'cuisine \n',
                  style: TextStyle(
                    color: const Color(0xfffbce01),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'familiale',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            //authBloc.logout();
          },
          child: Container(
            margin: EdgeInsets.only(right: 20, top: 20),
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 4.0), //(x,y)
                  blurRadius: 10.0,
                  spreadRadius: -7,
                ),
              ],
              image: DecorationImage(
                  image: AssetImage('assets/images/reservation_btn.png'),
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ],
    );
  }
}

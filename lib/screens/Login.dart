import 'package:dar_sllah/blocs/auth_bloc.dart';
import 'package:dar_sllah/screens/Home%20Main/home_main_screen.dart';
import 'package:dar_sllah/screens/bottom_tab_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    authBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
        try {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => BottomTabScreen()));
        } catch (Exeption) {}
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_background_image.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 3.2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/dar_sllah_logo.png")),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 3.7,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Votre cuisine \nfamiliale',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: MediaQuery.of(context).size.width / 11.5,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                  height: 1.6388888888888888,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Discover Tunisian culture through other perspective\nby exploring the known ',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: MediaQuery.of(context).size.width / 26,
                  color: const Color(0xffffffff),
                  height: 1.875,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                width: double.infinity,
                height: MediaQuery.of(context).size.width / 7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login_facebook_btn.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                authBloc.googleLogin(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                width: double.infinity,
                height: MediaQuery.of(context).size.width / 7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login_google_btn.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dar_sllah/screens/bottom_tab_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:dar_sllah/services/auth_service.dart';

class AuthBloc {
  final googleSignIn = GoogleSignIn();
  final authService = AuthService();

  GoogleSignInAccount _user;
  Stream<User> get currentUser => authService.currentUser;

  GoogleSignInAccount get user => _user;

  Future googleLogin(BuildContext ctx) async {
    final googleUser = await googleSignIn.signIn();
    if (googleSignIn == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await authService.signInWithCredentail(credential);

    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomTabScreen()));
  }

    Future<void>logout() async{
    authService.logout();
    // fb.logOut();
    googleSignIn.signOut();
  }
}

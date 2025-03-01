// ignore_for_file: use_build_context_synchronously

import 'package:chat_bot/View/Authentication/sign_in.dart';
import 'package:chat_bot/View/Interface/interface_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SplashServices {
  //  INSTANCE FOR FIREBASE AUTHENTICATION'S CURRENT USER
  final User? auth = FirebaseAuth.instance.currentUser;
  //  METHOD TO SHOW SCREEN TO USER ACCORDING TO AUTHENTICATION
  Future<void> authGate(BuildContext context) async {
    if (auth != null) {
      //  IF USER IS ALREADY AUTHENTICATED, SHOW INTERFACE SCREEN
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
        Navigator.of(
          context,
        ).push(CupertinoPageRoute(builder: (context) => const InterfacePage()));
      });
    } else {
      //  IF USER IS NOT AUTHENTICATED, SHOW LOGIN SCREEN
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
        Navigator.of(
          context,
        ).push(CupertinoPageRoute(builder: (context) => const LoginPage()));
      });
    }
  }
}

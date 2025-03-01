import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController {
  //  INSTANCE FOR FIREBASE AUTHENTICATION
  final FirebaseAuth auth = FirebaseAuth.instance;

  //  METHOD TO REGISTER A NEW USER TO THE APPLICATION

  //  METHOD TO LOG THE USER INTO THE APPLICATION
  Future<void> signIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            log("User Logged In Successfully $email, $password");
          })
          .onError((error, stackTrace) {
            log("Failed Login Attempt $email, $password");
          });
    } catch (error) {
      log(error.toString());
    }
  }
}

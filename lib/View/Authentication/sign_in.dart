// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chat_bot/Controller/input_controllers.dart';
import 'package:chat_bot/View/Components/authentication_button.dart';
import 'package:chat_bot/View/Components/authentication_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //  INSTANCE FOR INPUT CONTROLLERS
  final InputControllers inputControllers = InputControllers();
  //  INSTANCE FOR FIREBASE AUTHENTICATION
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.055),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.grey.shade900,
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.01),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: height * 0.025,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'You\'ve been Missed',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: height * 0.015,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Form(
                      key: inputControllers.formKey,
                      child: Column(
                        children: [
                          AuthenticationField(
                            controller: inputControllers.emailController,
                            text: "Email",
                            icon: Icons.alternate_email,
                            obscure: false,
                          ),
                          SizedBox(height: height * 0.01),
                          AuthenticationField(
                            controller: inputControllers.passwordController,
                            text: "Password",
                            icon: Icons.password,
                            obscure: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    AuthenticationButton(
                      loading: inputControllers.loading,
                      text: 'Sign In',
                      onTap: () async {
                        if (inputControllers.formKey.currentState!.validate()) {
                          try {
                            setState(() {
                              inputControllers.loading = true;
                            });
                            await auth
                                .signInWithEmailAndPassword(
                                  email: inputControllers.emailController.text,
                                  password:
                                      inputControllers.passwordController.text,
                                )
                                .then((value) {
                                  setState(() {
                                    inputControllers.loading = false;
                                    inputControllers.emailController.clear();
                                    inputControllers.passwordController.clear();
                                  });
                                  Navigator.of(
                                    context,
                                  ).popAndPushNamed('/interface');
                                })
                                .onError((error, stackTrace) {
                                  setState(() {
                                    inputControllers.loading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red.shade800,
                                      content: Text(
                                        "Error Occurred While Logging into the Application.\nPlease try again Later!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } catch (error) {
                            log(error.toString());
                          }
                        }
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Text(
                          "Not a Member? ",
                          style: TextStyle(color: Colors.grey.shade300),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).popAndPushNamed('/register');
                          },
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chat_bot/Controller/input_controllers.dart';
import 'package:chat_bot/View/Components/authentication_button.dart';
import 'package:chat_bot/View/Components/authentication_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //  INSTANCE FOR INPUT CONTROLLERS
  final InputControllers inputControllers = InputControllers();
  //  INSTANCE FOR FIREBASE AUTHENTICATION
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Color(0xFF000000),
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
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: height * 0.025,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Let\'s make magic Happen',
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
                            controller: inputControllers.nameController,
                            text: "Name",
                            icon: Icons.person,
                            obscure: false,
                          ),
                          SizedBox(height: height * 0.01),
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
                      text: 'Get Started',
                      onTap: () async {
                        if (inputControllers.formKey.currentState!.validate()) {
                          try {
                            setState(() {
                              inputControllers.loading = true;
                            });
                            await auth
                                .createUserWithEmailAndPassword(
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
                                        "Error Occurred While Trying to Sign Up",
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
                          "Already a Member? ",
                          style: TextStyle(color: Colors.grey.shade300),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).popAndPushNamed('/login');
                          },
                          child: Text(
                            "Sign In",
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

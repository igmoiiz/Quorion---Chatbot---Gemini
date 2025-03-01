import 'dart:developer';

import 'package:chat_bot/Controller/Backend/chatbot_controller.dart';
import 'package:chat_bot/View/Authentication/register.dart';
import 'package:chat_bot/View/Authentication/sign_in.dart';
import 'package:chat_bot/View/Interface/interface_page.dart';
import 'package:chat_bot/View/Splash/splash_screen.dart';
import 'package:chat_bot/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
        log("Firebase Initialized!");
        runApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ChatbotController()),
            ],
            child: const MyApp(),
          ),
        );
      })
      .onError((error, stackTrace) {
        log("Firebase Initialization Failed!");
      });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quorion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.montserrat().fontFamily),
      initialRoute: '/splash',
      routes: {
        '/interface': (context) => const InterfacePage(),
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}

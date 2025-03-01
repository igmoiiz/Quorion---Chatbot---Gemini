import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot/Controller/Splash/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //  INSTANCE FOR SPLASH SERVICES
  final SplashServices splashServices = SplashServices();

  //  INITIALIZING THE STATE
  @override
  void initState() {
    splashServices.authGate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedTextKit(
              isRepeatingAnimation: true,
              totalRepeatCount: 100,
              repeatForever: true,
              pause: Duration(milliseconds: 5),
              animatedTexts: [
                FlickerAnimatedText(
                  "Quorion".toUpperCase(),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.035,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.cinzel().fontFamily,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Let's explore Possibilities",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          SizedBox(height: height * 0.2),
          CircularProgressIndicator(color: Colors.grey.shade700),
        ],
      ),
    );
  }
}

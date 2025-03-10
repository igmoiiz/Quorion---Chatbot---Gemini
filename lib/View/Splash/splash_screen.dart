import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot/Controller/Splash/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  //  INSTANCE FOR SPLASH SERVICES
  final SplashServices splashServices = SplashServices();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
    splashServices.authGate(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A1A),
                  Color(0xFF000000),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF6750A4).withOpacity(0.3),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: true,
                        totalRepeatCount: 100,
                        repeatForever: true,
                        pause: Duration(milliseconds: 500),
                        animatedTexts: [
                          FlickerAnimatedText(
                            "Quorion".toUpperCase(),
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.045,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.cinzel().fontFamily,
                              letterSpacing: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Opacity(
                    opacity: _opacityAnimation.value,
                    child: Text(
                      "Let's explore Possibilities",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: height * 0.018,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.15),
                  Opacity(
                    opacity: _opacityAnimation.value,
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF6750A4).withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: CircularProgressIndicator(
                        color: Color(0xFF6750A4),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

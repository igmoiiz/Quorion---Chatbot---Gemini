import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onTap;
  final String text;
  const AuthenticationButton({
    super.key,
    required this.text,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height * 0.05,
          decoration: BoxDecoration(
            color: Colors.green.shade800,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child:
                loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                      text.toUpperCase(),
                      style: TextStyle(
                        fontSize: height * 0.020,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}

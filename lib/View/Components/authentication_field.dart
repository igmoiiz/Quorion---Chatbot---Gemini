import 'package:flutter/material.dart';

class AuthenticationField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData icon;
  final bool obscure;
  const AuthenticationField({
    super.key,
    required this.controller,
    required this.text,
    required this.icon,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$text can not be empty';
          } else {
            return null;
          }
        },
        style: const TextStyle(color: Colors.white), // White text input
        cursorColor: Colors.white, // White cursor
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(color: Colors.grey[400]), // Lighter grey label
          prefixIcon: Icon(icon, color: Colors.grey[400]), // Grey prefix icon
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey[600]!), // Grey border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Colors.white,
            ), // White focused border
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.grey[600]!,
            ), // Resting border same as enabled
          ),
        ),
      ),
    );
  }
}

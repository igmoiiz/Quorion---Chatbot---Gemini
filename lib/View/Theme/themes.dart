import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//  LIGHT MODE
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: GoogleFonts.outfit().fontFamily,
  colorScheme: ColorScheme.light(),
);

//  DARK MODE
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.outfit().fontFamily,
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    surface: Color(0xFF121212),
    primary: Color(0xFF0A84FF),
    secondary: Color(0xFF30D158),
    onPrimary: Color(0xFF1E1E1E),
    tertiary: Color(0xFFEAEAEA),
    onTertiary: Color(0xFFA1A1A1),
    error: Color(0xFFFF453A),
    inverseSurface: Color(0xFF2C2C2E),
  ),
);

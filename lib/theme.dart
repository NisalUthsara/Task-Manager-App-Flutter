import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBlack = Color(0xFF171717);
  static const Color primaryOrange = Color(0xFFF2572B);
  static const Color secondaryDarkGray = Color(0xFF4D4D4D);
  static const Color secondaryLightGray = Color(0xFFDEDEDE);

  static ThemeData apptheme = ThemeData(
    textTheme: TextTheme(
      displayLarge: GoogleFonts.russoOne(
        fontSize: 90,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.russoOne(
        fontSize: 54,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.russoOne(
        fontSize: 34,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

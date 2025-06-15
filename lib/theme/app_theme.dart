import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: navyBlue, // Navy Blue
    scaffoldBackgroundColor: cream, // Light Cream
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: navyBlue,
      secondary: gold, // Soft Gold
    ),
    textTheme: GoogleFonts.cairoTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: navyBlue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: navyBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static const Color navyBlue = Color(0xFF1A237E);
  static const Color gold = Color(0xFFFFC107);
  static const Color cream = Color(0xFFFDFDFD);
}

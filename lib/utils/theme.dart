import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final churchLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF002366), // Royal Blue
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF002366), // Royal Blue
    secondary: const Color(0xFFB76E79), // Soft Burgundy
    background: Colors.white,
    surface: const Color(0xFFF6F6F6),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: Colors.black87,
    onSurface: Colors.black87,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    shadowColor: Colors.black12,
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.cormorantGaramond(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFBFA14A), // Gold
    ),
    titleLarge: GoogleFonts.cormorantGaramond(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF002366),
    ),
    bodyLarge: GoogleFonts.openSans(fontSize: 16, color: Colors.black87),
    bodyMedium: GoogleFonts.openSans(fontSize: 14, color: Colors.black54),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    buttonColor: const Color(0xFFBFA14A), // Gold
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Color(0xFF002366)),
    titleTextStyle: GoogleFonts.cormorantGaramond(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF002366),
    ),
  ),
);

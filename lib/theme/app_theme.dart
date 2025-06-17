import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // New Church Theme Colors
  static const Color churchBlue = Color(0xFF003366);
  static const Color churchGold = Color(0xFFD4AF37);
  static const Color churchCream = Color(0xFFFFF8DC);
  static const Color churchRed = Color(0xFF8B0000); // For errors or destructive actions
  static const Color churchDarkText = Color(0xFF333333);
  static const Color churchLightText = Color(0xFFFFF8DC); // Same as churchCream

  // Old Colors (can be kept for specific widgets or gradually phased out)
  // For this refactor, we are primarily focusing on the new church theme for core elements.
  // static const Color primaryColorOld = Color(0xFF1A237E); // Dark Blue
  // static const Color secondaryColorOld = Color(0xFFFFC107); // Amber
  static const Color accentColor = Color(0xFF536DFE); // Kept if still needed, or could be churchGold
  // static const Color backgroundColorOld = Color(0xFFF5F5F7); // Light Gray
  static const Color surfaceColor = Colors.white; // Standard white for surfaces like cards
  // static const Color errorColorOld = Color(0xFFE53935);

  // Custom Widget Specific Colors from previous theme (to be replaced by new theme colors)
  // static const Color customButtonGold = Color(0xFFBFA14A); // Will become churchGold or similar
  // static const Color customIconBlue = Color(0xFF002366); // Will become churchBlue
  // static const Color customTextFieldFill = Color(0xFFF6F6F6); // Will become churchCream or light variant

  // Old Text Colors (to be replaced by new theme text colors)
  // static const Color primaryTextColorOld = Color(0xFF212121);
  // static const Color secondaryTextColorOld = Color(0xFF757575);
  
  // Custom Shadows (can be kept as is)
  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: churchBlue, // Updated
    scaffoldBackgroundColor: churchCream, // Updated

    colorScheme: const ColorScheme.light(
      primary: churchBlue,       // Updated
      secondary: churchGold,     // Updated
      surface: surfaceColor,     // Keep as white for cards etc.
      background: churchCream,   // Updated
      error: churchRed,          // Updated
      onPrimary: churchLightText,  // Text on churchBlue
      onSecondary: churchDarkText, // Text on churchGold
      onSurface: churchDarkText,   // Text on white surfaces
      onBackground: churchDarkText,// Text on churchCream background
      onError: churchLightText,    // Text on churchRed
      brightness: Brightness.light,
    ),
    
    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: churchBlue, // Updated
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.lato( // Updated font
        color: churchLightText,      // Updated
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: churchLightText, size: 28), // Updated
    ),
    
    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: churchGold,    // Updated
        foregroundColor: churchDarkText, // Updated (for contrast on gold)
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        textStyle: GoogleFonts.lato(   // Updated font
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Text Theme using Lato
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      displayLarge: GoogleFonts.lato(fontSize: 32, fontWeight: FontWeight.bold, color: churchBlue), // Example
      displayMedium: GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.bold, color: churchBlue),// Example
      headlineSmall: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold, color: churchBlue),// Example
      titleLarge: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w600, color: churchDarkText),
      titleMedium: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600, color: churchDarkText),
      titleSmall: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600, color: churchDarkText),
      bodyLarge: GoogleFonts.lato(fontSize: 16, color: churchDarkText), // Updated
      bodyMedium: GoogleFonts.lato(fontSize: 14, color: churchDarkText), // Updated
      labelLarge: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600, color: churchDarkText), // For buttons if needed
    ),
    
    // Icon Theme (Global fallback)
    iconTheme: const IconThemeData(color: churchGold), // Updated

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white, // Or a very light cream like churchCream.withOpacity(0.5)
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none, // Keep clean look
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1), // Subtle border
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: churchGold, width: 2), // Updated
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: churchRed, width: 1.5), // Updated
      ),
      labelStyle: GoogleFonts.lato( // Updated font
        color: churchDarkText.withOpacity(0.8),
        fontSize: 14,
      ),
      hintStyle: GoogleFonts.lato( // Updated font
        color: Colors.grey.shade500,
        fontSize: 14,
      ),
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      color: surfaceColor, // Keep cards white to stand out on churchCream bg
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(8),
    ),
    
    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: surfaceColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: GoogleFonts.lato( // Updated font
        color: churchDarkText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: GoogleFonts.lato( // Updated font
        color: churchDarkText,
        fontSize: 16,
      ),
    ),
    
    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentTextStyle: GoogleFonts.lato( // Updated font
        color: churchLightText, // Assuming snackbars have dark background by default
        fontSize: 14,
      ),
    ),
  );
}

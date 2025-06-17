import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_good_shepherd/theme/app_theme.dart'; // Added import

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      style: GoogleFonts.openSans(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryTextColor, // Use AppTheme
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppTheme.customIconBlue) // Use AppTheme
            : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppTheme.customTextFieldFill, // Use AppTheme
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppTheme.customButtonGold, width: 2), // Use AppTheme
        ),
      ),
    );
  }
}

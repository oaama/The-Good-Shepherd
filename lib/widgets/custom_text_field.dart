import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          color: Colors.black87,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Color(0xFF002366))
            : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
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
          borderSide: const BorderSide(color: Color(0xFFBFA14A), width: 2),
        ),
      ),
    );
  }
}

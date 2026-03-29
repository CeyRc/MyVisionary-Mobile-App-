import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color backgroundColor = Color(0xFFF5F6FA);
  static const Color textFieldFillColor = Color(0xFFEDEDED);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
    ),
  );
}
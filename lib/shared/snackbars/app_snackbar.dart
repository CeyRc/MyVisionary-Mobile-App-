import 'package:flutter/material.dart';

class AppSnackbar {
  AppSnackbar._(); // private constructor, sadece static metod kullanılır

  static void show(
      BuildContext context, {
        required String message,
        Color backgroundColor = Colors.black87,
        Duration duration = const Duration(seconds: 2),
      }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );

    // ScaffoldMessenger kullan
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
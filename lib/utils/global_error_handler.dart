import 'package:flutter/material.dart';

class GlobalErrorHandler {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void showError(String message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color.fromARGB(255, 165, 103, 98),
        ),
      );
    } else {
      print("Error: $message"); // fallback
    }
  }
}

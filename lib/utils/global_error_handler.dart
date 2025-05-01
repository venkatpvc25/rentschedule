import 'package:flutter/material.dart';
import 'package:rentschedule/theme/theme.dart';

extension MessageExtension on BuildContext {
  void showMessage(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.lightTheme.primaryColor,
      ),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}

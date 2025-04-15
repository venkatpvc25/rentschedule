import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  String email = '';
  String password = '';

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  bool validateCredentials() {
    return email.isNotEmpty && password.isNotEmpty;
  }
}
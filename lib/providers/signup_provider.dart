import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  String name = '';
  String email = '';
  String password = '';

  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  bool validateSignUp() {
    return name.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
  }
}

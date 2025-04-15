// import 'package:flutter/material.dart';
// import 'package:otp_login/otp_login.dart';
// import 'package:provider/provider.dart';

// class OTPLoginPage1 extends StatelessWidget {
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();

//   OTPLoginPage1({super.key});

//   bool isValidPhoneNumber(String phone) {
//     final pattern = RegExp(r'^\+\d{10,13}$');
//     return pattern.hasMatch(phone);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:

// ChangeNotifierProvider(
//   create: (_) => OTPProvider(),
//   child: OTPLoginPage(
//     onLoginSuccess: (token) {
//       print("✅ Logged in with Firebase ID token: $token");
//     },
//   ),
// ),
//     );
//   }
// }

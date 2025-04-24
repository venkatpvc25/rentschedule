import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rentschedule/providers/loader_provider.dart';
import 'package:rentschedule/supbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpAuthProvider with ChangeNotifier {
  String? error;
  bool isLoading = false;
  bool canResend = false;
  bool isOtpSent = false;
  int seconds = 30;
  late Timer timer;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final LoaderProvider loader;
  final supabase = SupabaseClientInstance.client;

  OtpAuthProvider({required this.loader});

  String get phoneNumber {
    return phoneController.text.isNotEmpty
        ? '+91 ${phoneController.text.trim()}'
        : '';
  }

  Future<bool> sendOTP() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      loader.showLoader();

      final response = await supabase.auth.signInWithOtp(phone: phoneNumber);

      isOtpSent = true;
      startCountdown();
      return true;
    } catch (e) {
      error = "Failed to send OTP. Try again.";
      return false;
    } finally {
      isLoading = false;
      loader.hideLoader();
      notifyListeners();
    }
  }

  Future<bool> verifyOTP(String phone, String otp) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      loader.showLoader();

      final response = await supabase.auth.verifyOTP(
        phone: phoneNumber,
        token: otp,
        type: OtpType.sms,
      );

      return response.session != null;
    } catch (e) {
      error = "Invalid OTP or verification failed.";
      return false;
    } finally {
      isLoading = false;
      loader.hideLoader();
      notifyListeners();
    }
  }

  Future<void> resendOTP() async {
    isLoading = true;
    notifyListeners();
    try {
      await supabase.auth.signInWithOtp(phone: phoneNumber);
      startCountdown();
    } catch (e) {
      error = "Failed to resend OTP.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void startCountdown() {
    canResend = false;
    seconds = 30;
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
        canResend = true;
      } else {
        seconds--;
      }
      notifyListeners();
    });
  }

  void reset() {
    isOtpSent = false;
    phoneController.text = '';
    otpController.clear();
    error = null;
    seconds = 30;
    canResend = false;
    notifyListeners();
  }
}

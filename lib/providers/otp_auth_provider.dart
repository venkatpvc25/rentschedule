import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpAuthProvider with ChangeNotifier {
  bool isLoading = false;
  String? error;

  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> signInWithPhone(String phone) async {
    isLoading = true;
    notifyListeners();
    error = null;

    await supabase.auth.signInWithOtp(phone: phone);
    // if (res.user == null && res.session == null) {
    //   error = 'OTP sent but user not signed in yet';
    // }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> verifyOTP(String phone, String token) async {
    isLoading = true;
    notifyListeners();
    error = null;

    try {
      final response = await supabase.auth.verifyOTP(
        type: OtpType.sms,
        token: token,
        phone: phone,
      );

      if (response.session != null) {
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        error = "Invalid OTP or verification failed.";
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    notifyListeners();
  }
}

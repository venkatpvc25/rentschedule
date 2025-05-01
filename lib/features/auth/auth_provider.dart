import 'package:flutter/material.dart';
import 'package:rentschedule/logger.dart';
import 'package:rentschedule/models/api_response.dart';
import 'package:rentschedule/models/profiles.dart';
import 'package:rentschedule/services/onboarding_service.dart';
import 'package:rentschedule/supbase.dart';
import 'package:rentschedule/providers/loader_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient _client = SupabaseClientInstance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final OnboardingService onboardingService = OnboardingService();
  final log = AppLogger('AuthService');
  final LoaderProvider loader;
  Profiles? _profile;

  bool _isOptSent = false;
  bool get isOptSent => _isOptSent;
  void set isOptSent(bool val) {
    _isOptSent = val;
    notifyListeners();
  }

  AuthProvider({required this.loader});

  User? get currentUser => _client.auth.currentUser;

  void set profile(Profiles? profile) {
    _profile = profile;
    notifyListeners();
  }

  Profiles? get profile => _profile;

  bool isLandlord() {
    return profile?.role == Role.LANDLORD;
  }

  bool isTenant() {
    return profile?.role == Role.TENANT;
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    notifyListeners();
    return response;
  }

  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    notifyListeners();
    return response;
  }

  /// Send OTP to the email (magic link if token not set in template)
  Future<ApiResponse<bool>> sendOtp() async {
    try {
      loader.showLoader();
      final email = emailController.text.trim();
      await _client.auth.signInWithOtp(
        email: email,
        shouldCreateUser: true,
        emailRedirectTo: null,
      );
      isOptSent = true;
      return ApiResponse(success: true, message: 'OTP sent successfully');
    } catch (e) {
      if (e is AuthException && e.message == 'User already registered') {
        log.w('User already registered');
        return ApiResponse(success: false, message: 'User already registered');
      } else {
        log.e('Error sending OTP: $e');
        return ApiResponse(success: false, message: 'Error sending OTP: $e');
      }
    } finally {
      loader.hideLoader();
    }
  }

  /// Sign in with OTP
  Future<ApiResponse<bool>> signInWithOtp({
    void Function(User?)? onVerified,
  }) async {
    try {
      loader.showLoader();
      final email = emailController.text.trim();
      final otp = otpController.text.trim();

      final response = await _client.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.email,
      );
      if (response.user != null) {
        onVerified?.call(response.user);
        return ApiResponse(success: true, message: 'OTP verified successfully');
      }
      return ApiResponse(success: true, message: 'Error verifying OTP');
    } catch (e) {
      if (e is AuthApiException) {
        log.e('Error verifying OTP: ${e.message}');
        return ApiResponse(success: true, message: 'Error verifying OTP');
      } else {
        log.e('Error verifying OTP: $e');
        return ApiResponse(success: true, message: 'Error verifying OTP');
      }
    } finally {
      loader.hideLoader();
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }
}

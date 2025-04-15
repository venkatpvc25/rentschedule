
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _client;

  AuthService(this._client);

  User? get currentUser => _client.auth.currentUser;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signUp(email: email, password: password);
    notifyListeners();
    return response;
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(email: email, password: password);
    notifyListeners();
    return response;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
    notifyListeners();
  }

  Future<void> resetPassword({required String email}) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  Future<void> updatePassword(String newPassword) async {
    await _client.auth.updateUser(UserAttributes(password: newPassword));
    notifyListeners();
  }
}


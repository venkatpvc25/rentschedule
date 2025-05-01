import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:rentschedule/services/onboarding_service.dart';
import 'package:rentschedule/supbase.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.microtask(() async {
      final session = SupabaseClientInstance.client.auth.currentSession;
      final auth = Provider.of<AuthProvider>(context, listen: false);
      if (session != null) {
        // Try fetching profile
        await OnboardingService()
            .onBoardingUser(session.user.email ?? '')
            .then((response) {
              if (response.data != null) {
                auth.profile = response.data;
                context.goNamed('dashboard');
              } else {
                // No profile, force login
                context.goNamed('otp');
              }
            })
            .catchError((e) {
              // Handle fetch error, go to OTP/login
              context.goNamed('otp');
            });
      } else {
        context.goNamed('otp');
      }
    });
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

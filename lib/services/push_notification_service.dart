import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rentschedule/models/profiles.dart';
import 'package:rentschedule/services/onboarding_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final GlobalKey<NavigatorState> navigatorKey;
  final User? user;

  PushNotificationService(this.navigatorKey, this.user);

  Future<void> init() async {
    // Request permission
    NotificationSettings settings = await _fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await _fcm.getToken();
      Profiles profile = Profiles();
      profile = profile.copyWith(email: user?.email, fcmToken: token);
      OnboardingService().updateProfile(profile);
    }

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.notification?.title}');
      // Optionally show an in-app snackbar or dialog
    });

    // Background and terminated app handling
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final route = message.data['route']; // e.g., /paymentStatus
      if (route != null) {
        navigatorKey.currentState?.pushNamed(route);
      }
    });
  }
}

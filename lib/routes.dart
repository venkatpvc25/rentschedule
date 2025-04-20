import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentschedule/features/razor/razorpay_subscription_screen.dart';
import 'package:rentschedule/features/razor/subscription_list_screen.dart';
import 'package:rentschedule/screens/add_tenancy_screen.dart';
import 'package:rentschedule/screens/dashboard_screen.dart';
import 'package:rentschedule/screens/otp_login_screen.dart';
import 'package:rentschedule/screens/rent_schedule.dart';
import 'package:rentschedule/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _supabase = Supabase.instance.client;

bool isLoggedIn() {
  return Supabase.instance.client.auth.currentSession != null;
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final loggedIn = Supabase.instance.client.auth.currentSession != null;
    final goingToLogin = state.fullPath == '/';

    if (!loggedIn && !goingToLogin) {
      return '/';
    }

    if (loggedIn && goingToLogin) {
      return '/dashboard';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/otp',
      name: 'otp',
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone']!;
        return OTPScreen(phone: phone);
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => SubscriptionListScreen(),
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home', // default redirect
    ),
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'subscription',
      builder: (context, state) => SubscriptionScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/rent-schedule',
      name: 'rentSchedule',
      builder: (context, state) => const RentScheduleScreen(),
    ),
    GoRoute(
      path: '/add-tenant',
      name: 'addTenant',
      builder: (context, state) => const AddTenantTenancyScreen(),
    ),
  ],
);

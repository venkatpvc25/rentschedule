import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentschedule/features/auth/signup_screen.dart';
import 'package:rentschedule/features/dashboard/dashboard_wrapper.dart';
import 'package:rentschedule/features/razor/razorpay_subscription_screen.dart';
import 'package:rentschedule/features/razor/subscription_list_screen.dart';
import 'package:rentschedule/splash_screen.dart';
import 'package:rentschedule/supbase.dart';
import 'package:rentschedule/widgets/subscription_web_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash', // Show splash screen first
  redirect: (context, state) {
    final loggedIn = SupabaseClientInstance.client.auth.currentSession != null;
    final goingToSplash = state.fullPath == '/splash';
    final goingToLogin = state.fullPath == '/otp';

    if (goingToSplash) {
      // Don't redirect away from splash
      return null;
    }

    if (!loggedIn && !goingToLogin) {
      return '/otp';
    }

    if (loggedIn && goingToLogin) {
      return '/dashboard';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/otp',
      name: 'otp',
      builder: (context, state) => EmailAuthScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => SubscriptionListScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'subscription',
      builder: (context, state) => SubscriptionScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardWrapper(),
      routes: [
        GoRoute(
          path: 'web-view', // Note: no leading slash here
          name: 'tenant-subscription',
          builder: (context, state) => WebView(),
        ),
      ],
    ),
    GoRoute(
      path: '/rent-schedule',
      name: 'rent-schedule',
      builder: (context, state) => SubscriptionScreen(),
    ),
    GoRoute(
      path: '/add-tenant',
      name: 'add-tenant',
      builder: (context, state) => SubscriptionScreen(),
    ),
  ],
);

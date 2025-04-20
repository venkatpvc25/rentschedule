import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:rentschedule/features/razor/razorpay_provider.dart';
import 'package:rentschedule/features/razor/razorpay_subscription_screen.dart';
import 'package:rentschedule/providers/add_tenan_provider.dart';
import 'package:rentschedule/providers/loader_provider.dart';
import 'package:rentschedule/providers/signin_provider.dart';
import 'package:rentschedule/providers/signup_provider.dart';
import 'package:rentschedule/routes.dart';
import 'package:rentschedule/screens/add_tenancy_screen.dart';
import 'package:rentschedule/features/auth/signup_screen.dart';
import 'package:rentschedule/screens/dashboard_screen.dart';
import 'package:rentschedule/screens/rent_schedule.dart';
import 'package:rentschedule/splash_screen.dart';
import 'package:rentschedule/theme/theme.dart';
import 'package:rentschedule/utils/global_error_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const String supabaseUrl = 'https://mjepwlbtbqahkptlijid.supabase.co';
  const String supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1qZXB3bGJ0YnFhaGtwdGxpamlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI5NjQzMDIsImV4cCI6MjA1ODU0MDMwMn0.bJUS4hfQIxjHQdBU64IQ6l3eZwUGBd_It9e2a89VP2I';
  SupabaseClient supabaseClient = SupabaseClient(supabaseUrl, supabaseKey);

  final session = Supabase.instance.client.auth.currentSession;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => AddTenantProvider()),
        ChangeNotifierProvider(create: (_) => AuthService(supabaseClient)),
        ChangeNotifierProvider(create: (_) => LoaderProvider()),
      ],
      child: MyApp(isLoggedIn: session != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.isLoggedIn = false});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      // initialRoute: '/splash',
      // routes: {
      //   '/splash': (context) => const SplashScreen(),
      //   //'/': (context) => const SignInScreen(),
      //   '/': (context) => SubscriptionScreen(),
      //   '/dashboard': (context) => const DashboardScreen(),
      //   '/rent-schedule': (context) => const RentScheduleScreen(),
      //   '/add-tenant': (context) => const AddTenantTenancyScreen(),
      // },
    );
  }
}

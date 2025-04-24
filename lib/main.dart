import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:rentschedule/providers/loader_provider.dart';
import 'package:rentschedule/providers/otp_auth_provider.dart';
import 'package:rentschedule/routes.dart';
import 'package:rentschedule/supbase.dart';
import 'package:rentschedule/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SupabaseClientInstance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoaderProvider()),
        ChangeNotifierProvider(
          create:
              (context) => AuthProvider(
                loader: Provider.of<LoaderProvider>(context, listen: false),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => OtpAuthProvider(
                loader: Provider.of<LoaderProvider>(context, listen: false),
              ),
        ),
      ],
      child: MyApp(
        isLoggedIn: SupabaseClientInstance.client.auth.currentSession != null,
      ),
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

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:rentschedule/providers/loader_provider.dart';
import 'package:rentschedule/providers/otp_auth_provider.dart';
import 'package:rentschedule/routes.dart';
import 'package:rentschedule/services/push_notification_service.dart';
import 'package:rentschedule/supbase.dart';
import 'package:rentschedule/theme/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.notification?.title}');
  if (message.data['route'] != null) {
    print("Navigate to route ${message.data['route']}");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await SupabaseClientInstance.initialize();

  final navigatorKey = GlobalKey<NavigatorState>();
  final notificationService = PushNotificationService(
    navigatorKey,
    SupabaseClientInstance.client.auth.currentSession?.user,
  );
  await notificationService.init();

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

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.isLoggedIn = false});

  final bool isLoggedIn;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // _initializeFirebaseMessaging();
    // _initializeLocalNotifications();
  }

  // Future<void> _showLocalNotification(RemoteMessage message) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //         'your_channel_id',
  //         'your_channel_name',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //         showWhen: false,
  //       );
  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //   );

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     message.notification?.title,
  //     message.notification?.body,
  //     platformChannelSpecifics,
  //     payload: 'item x',
  //   );
  // }

  // Future<void> _initializeFirebaseMessaging() async {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Foreground message received: ${message.notification?.title}');
  //     _showLocalNotification(message);
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('Message clicked! ${message.notification?.title}');
  //     // Handle navigation or other logic
  //   });

  //   NotificationSettings settings =
  //       await _firebaseMessaging.requestPermission();
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     final token = await _firebaseMessaging.getToken();
  //     print("FCM Token: $token");
  //   }
  // }

  // Future<void> _initializeLocalNotifications() async {
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('app_icon');

  //   const InitializationSettings initializationSettings =
  //       InitializationSettings(android: initializationSettingsAndroid);

  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          TextButton(
            onPressed: () async {
              print('object');
              auth.isOptSent = false;
              await auth.signOut();
              context.pushReplacementNamed('otp');
            },
            child: Text('Sign out'),
          ),
        ],
      ),
      body: Center(child: const Text('Welcome to the Dashboard!')),
    );
  }
}

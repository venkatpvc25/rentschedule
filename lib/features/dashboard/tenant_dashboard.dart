import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:rentschedule/screens/dashboard_screen.dart';

class TenantDashboardScreen extends StatefulWidget {
  const TenantDashboardScreen({super.key});

  @override
  State<TenantDashboardScreen> createState() => _TenantDashboardScreenState();
}

class _TenantDashboardScreenState extends State<TenantDashboardScreen> {
  int currentIndex = 0;
  late AuthProvider auth;

  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    auth = Provider.of<AuthProvider>(context, listen: false);
    screens = [
      const HomeScreen(),
      const Center(child: Text("Explore")),
      const Center(child: Text("Activity")),
      const Center(child: Text("Inbox")),
      Center(
        child: Column(
          children: [
            Text("Profile"),
            TextButton(
              onPressed: () async {
                signOut();
                context.pushReplacementNamed('otp');
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    ];
  }

  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.house), label: "My Tenancy"),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Payments"),
          BottomNavigationBarItem(icon: Icon(Icons.support), label: "Support"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

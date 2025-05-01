import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:rentschedule/features/dashboard/empty_landlord_dashboard.dart';
import 'package:rentschedule/screens/dashboard_screen.dart';

class LandlordDashboardScreen extends StatefulWidget {
  const LandlordDashboardScreen({super.key});

  @override
  State<LandlordDashboardScreen> createState() =>
      _LandlordDashboardScreenState();
}

class _LandlordDashboardScreenState extends State<LandlordDashboardScreen> {
  int currentIndex = 0;
  late AuthProvider auth;

  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    auth = Provider.of<AuthProvider>(context, listen: false);
    screens =
        screens = [
          EmptyLandlordDashboard(),
          const Center(child: Text("Payments")),
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
    ;
  }

  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () => context.pushNamed('rent-schedule'),
        icon: const Icon(Icons.add),
        label: const Text('Add Tenancy'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.business),
          //   label: "Properties",
          // ),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Payments"),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Inbox",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

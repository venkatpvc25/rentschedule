import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on),
            label: "Activity",
          ),
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.card_giftcard, size: 28, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "You got 20% discount!\nWelcome to your first sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Search bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search properties or tenants",
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Action cards (similar to Condo, Apartment…)
            Row(
              children: const [
                Expanded(
                  child: CategoryCard(
                    title: "Add Tenancy",
                    icon: Icons.add_home,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CategoryCard(
                    title: "View Tenancies",
                    icon: Icons.home_work,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Nearby section (used for listing)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Tenancies",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ],
            ),

            const SizedBox(height: 12),
            PropertyListTile(title: "Dream Heights", tenants: 3),
            PropertyListTile(title: "City Villas", tenants: 5),
            PropertyListTile(title: "Emerald Tower", tenants: 2),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.deepPurpleAccent, size: 30),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class PropertyListTile extends StatelessWidget {
  final String title;
  final int tenants;

  const PropertyListTile({
    super.key,
    required this.title,
    required this.tenants,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      leading: const Icon(Icons.apartment, color: Colors.deepPurpleAccent),
      title: Text(title),
      subtitle: Text("$tenants active tenancies"),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}

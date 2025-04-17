import 'package:flutter/material.dart';
import 'package:rentschedule/features/razor/tenant_detail_screen.dart';

class SubscriptionListScreen extends StatelessWidget {
  final List<Map<String, String>> subscriptions = [
    {"id": "1", "tenantName": "John Doe", "subscriptionAmount": "1000"},
    {"id": "2", "tenantName": "Jane Smith", "subscriptionAmount": "1500"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subscriptions")),
      body: ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          final subscription = subscriptions[index];
          return ListTile(
            title: Text(subscription["tenantName"]!),
            subtitle: Text("Amount: ₹${subscription["subscriptionAmount"]}"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => TenantDetailsScreen(
                        subscriptionId: subscription["id"]!,
                        tenantName: subscription["tenantName"]!,
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

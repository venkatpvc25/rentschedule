import 'package:flutter/material.dart';

class TenantDetailsScreen extends StatelessWidget {
  final String subscriptionId;
  final String tenantName;

  const TenantDetailsScreen({
    required this.subscriptionId,
    required this.tenantName,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> paymentHistory = [
      {"date": "2023-01-01", "amount": "1000", "status": "Paid"},
      {"date": "2023-02-01", "amount": "1000", "status": "Paid"},
      {"date": "2023-03-01", "amount": "1000", "status": "Pending"},
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Tenant Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tenant Name: $tenantName",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 20),
            Text(
              "Payment History",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: paymentHistory.length,
                itemBuilder: (context, index) {
                  final payment = paymentHistory[index];
                  return ListTile(
                    title: Text("Date: ${payment["date"]}"),
                    subtitle: Text("Amount: ₹${payment["amount"]}"),
                    trailing: Text(
                      payment["status"]!,
                      style: TextStyle(
                        color:
                            payment["status"] == "Paid"
                                ? Colors.green
                                : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GlobalSuccessScreen extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget>? details;
  final VoidCallback? onGoBack;

  const GlobalSuccessScreen({
    required this.title,
    required this.message,
    this.details,
    this.onGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: Colors.green),
            ),
            SizedBox(height: 20),
            if (details != null) ...details!,
            Spacer(),
            ElevatedButton(
              onPressed: onGoBack ?? () => Navigator.pop(context),
              child: Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}

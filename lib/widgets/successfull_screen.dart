import 'package:flutter/material.dart';

class GlobalSuccessScreen extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget>? details;
  final VoidCallback? onGoBack;
  final Widget? child;

  const GlobalSuccessScreen({
    required this.title,
    required this.message,
    this.details,
    this.onGoBack,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 20),
        if (child != null) child!,
        Spacer(),
        ElevatedButton(
          onPressed: onGoBack ?? () => Navigator.pop(context),
          child: Text("Go Back"),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;

  const BaseScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Global padding
      child: child,
    );
  }
}
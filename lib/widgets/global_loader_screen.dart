import 'package:flutter/material.dart';

class GlobalLoaderScreen extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const GlobalLoaderScreen({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child, // The main content of the screen
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
            child: const Center(
              child: CircularProgressIndicator(), // Loading indicator
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/providers/loader_provider.dart';

class GlobalLoaderScreen extends StatelessWidget {
  final Widget child;

  const GlobalLoaderScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, provider, item) {
        return Stack(
          children: [
            child,
            if (provider.isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(), // Loading indicator
                ),
              ),
          ],
        );
      },
    );
  }
}

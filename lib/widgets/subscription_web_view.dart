import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rentschedule/features/auth/auth_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  final String? shortUrl;

  const WebView({this.shortUrl});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(
              shortUrl ?? auth.profile?.pendingSubscription[0].shortUrl ?? '',
            ),
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              context.goNamed('dashboard');
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}

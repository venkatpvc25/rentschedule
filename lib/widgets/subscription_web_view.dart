import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SubscriptionWebView extends StatelessWidget {
  final String shortUrl;

  const SubscriptionWebView({required this.shortUrl});

  @override
  Widget build(BuildContext context) {
    final controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(shortUrl));

    return WebViewWidget(controller: controller);
  }
}

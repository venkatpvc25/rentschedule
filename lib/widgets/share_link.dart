import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareLinkWidget extends StatelessWidget {
  final String shortUrl;
  final String deepLink;
  final String playStoreLink;

  const ShareLinkWidget({
    super.key,
    required this.shortUrl,
    required this.deepLink,
    required this.playStoreLink,
  });

  void _shareContent() {
    final message = '''
      Hi! Please install our app and authorize the rent subscription.

      Install the app:
      $playStoreLink

      Once installed, you'll be redirected to authorize payment:
      $shortUrl
      ''';

    Share.share(message, subject: "Rent Payment Authorization");
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _shareContent,
      icon: Icon(Icons.share),
      label: Text("Share with Tenant"),
    );
  }
}

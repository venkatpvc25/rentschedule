import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentschedule/models/subscription_request.dart';
import 'package:rentschedule/widgets/base_screen.dart';
import 'package:rentschedule/widgets/share_link.dart';

class LandlordSubscriptionSuccessStepperScreen extends StatefulWidget {
  final SubscriptionRequest subscription;
  final String shortUrl;
  final VoidCallback onGoBack;
  final VoidCallback onCancelRequest;

  const LandlordSubscriptionSuccessStepperScreen({
    super.key,
    required this.subscription,
    required this.shortUrl,
    required this.onGoBack,
    required this.onCancelRequest,
  });

  @override
  State<LandlordSubscriptionSuccessStepperScreen> createState() =>
      _LandlordSubscriptionSuccessStepperScreenState();
}

class _LandlordSubscriptionSuccessStepperScreenState
    extends State<LandlordSubscriptionSuccessStepperScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade1;
  late Animation<double> _fade2;
  late Animation<double> _fade3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _fade1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4)),
    );
    _fade2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.7)),
    );
    _fade3 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.7, 1.0)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildStep(IconData icon, String label, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget buildShareBox() {
    // Function to copy the URL to the clipboard
    void _copyToClipboard() {
      Clipboard.setData(ClipboardData(text: widget.shortUrl));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('URL copied to clipboard')));
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Share this link:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 6),
          SelectableText(
            widget.shortUrl,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Copy URL Button
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy URL'),
                  onPressed: _copyToClipboard,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Share Button
              Expanded(
                child: ShareLinkWidget(
                  shortUrl: widget.shortUrl,
                  deepLink: "deepLink",
                  playStoreLink: "playStoreLink",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subscription = widget.subscription;

    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.celebration,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'All Set!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 24),

          /// Stepper-like animations
          buildStep(Icons.check_circle, 'Subscription Created', _fade1),
          const SizedBox(height: 10),
          buildStep(Icons.link, 'Share the link', _fade2),
          const SizedBox(height: 10),
          buildStep(Icons.done, 'You are done!', _fade3),

          const Divider(height: 32),

          // Subscription Details
          buildDetailRow('Email', subscription.email),
          buildDetailRow('Amount', '₹${subscription.amount}'),
          buildDetailRow('Quantity', '${subscription.quantity}'),
          buildDetailRow('Total Count', '${subscription.totalCount}'),
          if (subscription.startAt != null)
            buildDetailRow(
              'Start Date',
              DateTime.fromMillisecondsSinceEpoch(
                subscription.startAt! * 1000,
              ).toLocal().toString().split('.')[0],
            ),
          const SizedBox(height: 20),
          buildShareBox(),
          const SizedBox(height: 24),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel Request'),
                  onPressed: widget.onCancelRequest,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Go to Dashboard'),
                  onPressed: widget.onGoBack,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

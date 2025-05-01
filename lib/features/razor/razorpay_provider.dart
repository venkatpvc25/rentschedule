import 'package:flutter/material.dart';
import 'package:rentschedule/features/razor/razorpay_service.dart';
import 'package:rentschedule/models/subscription_request.dart';
import 'package:rentschedule/providers/loader_provider.dart';

class RazorpayProvider extends ChangeNotifier {
  final RazorpayService _razorpayService;
  final LoaderProvider _loader;

  final formKey = GlobalKey<FormState>();
  final subscriptionFormKey = GlobalKey<FormState>();

  // Plan controllers
  final emailController = TextEditingController();
  final amountController = TextEditingController();
  final totalCountController = TextEditingController();
  final quantityController = TextEditingController(text: '1');
  bool customerNotify = false;
  DateTime startAt = DateTime.now();

  RazorpayProvider(this._razorpayService, this._loader);

  String? shortUrl;

  final startDateController = TextEditingController();

  // need to check if any subscription is created for this tenant
  // if yes then show the subscription details
  // if no then show the subscription form

  Future<void> createSubscription() async {
    _loader.showLoader();
    notifyListeners();

    final response = await _razorpayService.createSubscription(subscription);

    if (response.hasError) {
      //context.showErro(response.error!);
      shortUrl = null;
    } else {
      shortUrl = response.data?.pendingSubscriptions?.first.shortUrl;
    }

    _loader.hideLoader();
    notifyListeners();
  }

  SubscriptionRequest? get subscription {
    if (!formKey.currentState!.validate()) return null;
    int startAtValue = startAt.millisecondsSinceEpoch ~/ 1000;

    return SubscriptionRequest(
      totalCount: int.parse(totalCountController.text.trim()),
      quantity: int.tryParse(quantityController.text.trim()) ?? 1,
      startAt: startAtValue,
      amount: int.parse(amountController.text.trim()) * 100,
      email: emailController.text,
    );
  }

  void setStartAt(DateTime date) {
    startAt = date;
    notifyListeners();
  }

  @override
  void dispose() {
    amountController.dispose();
    totalCountController.dispose();
    quantityController.dispose();

    super.dispose();
  }
}

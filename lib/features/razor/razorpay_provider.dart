import 'package:flutter/material.dart';
import 'package:rentschedule/features/razor/razorpay_service.dart';
import 'package:rentschedule/models/api_response.dart';
import 'package:rentschedule/models/subscription_request.dart';
import 'package:rentschedule/providers/loader_provider.dart';
import 'package:rentschedule/utils/global_error_handler.dart';

class RazorpayProvider extends ChangeNotifier {
  final RazorpayService _razorpayService;
  final LoaderProvider _loader;

  final formKey = GlobalKey<FormState>();
  final subscriptionFormKey = GlobalKey<FormState>();

  // Plan controllers
  final amountController = TextEditingController();
  final totalCountController = TextEditingController();
  final quantityController = TextEditingController(text: '1');
  bool customerNotify = false;
  DateTime? startAt;

  RazorpayProvider(this._razorpayService, this._loader);

  String? shortUrl;

  Future<void> createSubscription() async {
    _loader.showLoader();
    notifyListeners();

    final response = await _razorpayService.createSubscription(subscription);

    if (response.hasError) {
      GlobalErrorHandler.showError(response.error!);
      shortUrl = null;
    } else {
      shortUrl = response.data;
    }

    _loader.hideLoader();
    notifyListeners();
  }

  SubscriptionRequest? get subscription {
    if (!formKey.currentState!.validate()) return null;
    return SubscriptionRequest(
      totalCount: int.parse(totalCountController.text.trim()),
      quantity: int.tryParse(quantityController.text.trim()) ?? 1,
      startAt: startAt?.millisecondsSinceEpoch,
      amount: int.parse(amountController.text.trim()) * 100,
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

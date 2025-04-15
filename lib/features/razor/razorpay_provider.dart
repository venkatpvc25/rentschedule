import 'package:flutter/material.dart';
import 'package:rentschedule/features/razor/razorpay_service.dart';

class RazorpayProvider extends ChangeNotifier {
  final RazorpayService _razorpayService;

  RazorpayProvider(this._razorpayService);

  String? shortUrl;
  bool isLoading = false;

  Future<void> createSubscription(
    String email,
    String contact,
    int amount,
  ) async {
    isLoading = true;
    notifyListeners();

    shortUrl = await _razorpayService.createSubscription(
      email,
      contact,
      amount,
    );

    isLoading = false;
    notifyListeners();
  }
}

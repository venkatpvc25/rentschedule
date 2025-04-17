import 'package:flutter/material.dart';
import 'package:rentschedule/features/razor/razorpay_service.dart';
import 'package:rentschedule/models/api_response.dart';

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

    ApiResponse<String>? response = await _razorpayService.createSubscription(
      email,
      contact,
      amount,
    );

    if (response != null) {
      shortUrl = response.data;
    } else {
      shortUrl = null;
    }

    isLoading = false;
    notifyListeners();
  }
}

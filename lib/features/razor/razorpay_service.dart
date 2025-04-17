import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rentschedule/models/api_response.dart';
import 'package:rentschedule/services/dio_service.dart';

class RazorpayService {
  final Dio _dio = DioService().dio;

  Future<ApiResponse<String>?> createSubscription(
    String email,
    String contact,
    int amount,
  ) async {
    try {
      final response = await _dio.post(
        "/payments/create-subscription",
        queryParameters: {"amount": amount, "email": email, "contact": contact},
      );

      if (response.statusCode == 200) {
        return ApiResponse<String>.fromJson(
          response.data,
          (data) => data as String, // Parse the `data` field as a String
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error creating subscription: $e");
      return null;
    }
  }

  // pause subscription
  Future<ApiResponse<String>?> pauseSubscription(String subscriptionId) async {
    try {
      final response = await _dio.post(
        "/payments/pause-subscription",
        queryParameters: {"subscriptionId": subscriptionId},
      );

      if (response.statusCode == 200) {
        return ApiResponse<String>.fromJson(
          response.data,
          (data) => data as String, // Parse the `data` field as a String
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error pausing subscription: $e");
      return null;
    }
  }

  // resume subscription
  Future<ApiResponse<String>?> resumeSubscription(String subscriptionId) async {
    try {
      final response = await _dio.post(
        "/payments/resume-subscription",
        queryParameters: {"subscriptionId": subscriptionId},
      );

      if (response.statusCode == 200) {
        return ApiResponse<String>.fromJson(
          response.data,
          (data) => data as String, // Parse the `data` field as a String
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error resuming subscription: $e");
      return null;
    }
  }

  // cancel subscription
  Future<ApiResponse<String>?> cancelSubscription(String subscriptionId) async {
    try {
      final response = await _dio.post(
        "/payments/cancel-subscription",
        queryParameters: {"subscriptionId": subscriptionId},
      );

      if (response.statusCode == 200) {
        return ApiResponse<String>.fromJson(
          response.data,
          (data) => data as String, // Parse the `data` field as a String
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error cancelling subscription: $e");
      return null;
    }
  }
}

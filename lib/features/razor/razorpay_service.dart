import 'package:dio/dio.dart';
import 'package:rentschedule/services/dio_service.dart';

class RazorpayService {
  final Dio _dio = DioService().dio;

  Future<String?> createSubscription(
    String email,
    String contact,
    int amount,
  ) async {
    try {
      final response = await _dio.post(
        "/api/payments/create-subscription",
        queryParameters: {"amount": amount, "email": email, "contact": contact},
      );

      if (response.statusCode == 200) {
        return response.data.toString().replaceAll('"', '');
      } else {
        return null;
      }
    } catch (e) {
      // Handle errors (e.g., log them or rethrow)
      return null;
    }
  }
}

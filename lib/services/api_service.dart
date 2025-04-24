import 'package:dio/dio.dart';
import '../models/api_error.dart';
import 'dio_service.dart';

class ApiService {
  final Dio _dio = DioService().dio;

  Future<dynamic> fetchData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      if (e is DioException && e.error is ApiError) {
        throw e.error as Object;
      } else {
        throw ApiError('An unexpected error occurred.');
      }
    }
  }
}

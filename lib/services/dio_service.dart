import 'package:dio/dio.dart';
import 'package:rentschedule/models/api_error.dart';

class DioService {
  late Dio _dio;

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com', // Replace with your API base URL
        connectTimeout: const Duration(seconds: 10), // Connection timeout
        receiveTimeout: const Duration(seconds: 10), // Response timeout
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // Add authorization token or other headers here
      return handler.next(options);
    },
    onResponse: (response, handler) {
      // Handle successful responses
      return handler.next(response);
    },
    onError: (DioError error, handler) {
      String errorMessage;
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Connection timed out. Please try again.';
      } else if (error.type == DioExceptionType.badResponse) {
        // Handle HTTP errors
        switch (error.response?.statusCode) {
          case 400:
            errorMessage = 'Bad request. Please check your input.';
            break;
          case 401:
            errorMessage = 'Unauthorized. Please log in again.';
            break;
          case 500:
            errorMessage = 'Server error. Please try again later.';
            break;
          default:
            errorMessage = 'Something went wrong. Please try again.';
        }
      } else if (error.type == DioExceptionType.unknown) {
        errorMessage = 'No internet connection. Please check your network.';
      } else {
        errorMessage = 'Unexpected error occurred.';
      }

      // Pass the error message to the handler
      handler.next(DioError(
        requestOptions: error.requestOptions,
        error: ApiError(errorMessage),
      ));
    },
  ));
  }

  Dio get dio => _dio;
}
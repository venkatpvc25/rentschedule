import 'package:dio/dio.dart';

class DioErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return "Connection timed out. Please try again.";
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode ?? 0;
          if (statusCode >= 500) {
            return "Server is currently down. Please try again later.";
          } else if (statusCode == 404) {
            return "Requested resource not found.";
          } else if (statusCode == 401 || statusCode == 403) {
            return "Unauthorized access. Please log in again.";
          } else {
            return "Something went wrong (${statusCode}).";
          }
        case DioExceptionType.cancel:
          return "Request was cancelled.";
        case DioExceptionType.unknown:
        default:
          if (error.message?.contains("SocketException") == true) {
            return "No internet connection.";
          }
          return "Unexpected error occurred.";
      }
    } else {
      return "Unexpected error: $error";
    }
  }
}

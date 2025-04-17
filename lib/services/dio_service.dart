import 'package:dio/dio.dart';
import 'package:rentschedule/models/api_error.dart';
import 'package:rentschedule/strings.dart';

class DioService {
  late Dio _dio;

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8080',
        // connectTimeout: const Duration(seconds: 10),
        // receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("Request: ${options.method} ${options.path}");
          print("Headers: ${options.headers}");
          print("Data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("Response: ${response.statusCode} ${response.data}");
          return handler.next(response);
        },
        onError: (DioError error, handler) {
          print("Error: ${error.message}");
          print("Error Type: ${error.type}");
          print("Error Response: ${error.response?.data}");
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

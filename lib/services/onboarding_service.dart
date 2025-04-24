import 'package:dio/dio.dart';
import 'package:rentschedule/models/api_response.dart';
import 'package:rentschedule/models/profiles.dart';
import 'package:rentschedule/services/dio_service.dart';

class OnboardingService {
  final dio = DioService().dio;

  Future<ApiResponse<Profiles>> onBoardingUser(Profiles user) async {
    try {
      final response = await dio.post('/users/onboarding', data: user.toJson());

      if (response.statusCode == 200) {
        return ApiResponse<Profiles>.fromJson(
          response.data,
          (json) => Profiles.fromJson(json),
        );
      } else {
        throw Exception('Failed to onboard user: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception('User already exists');
      } else {
        throw Exception('Unexpected error: ${e.message}');
      }
    } catch (e) {
      rethrow;
    }
  }
}

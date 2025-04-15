import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rentschedule/services/dio_service.dart';
import 'package:rentschedule/theme/theme.dart';

final TextTheme textTheme = AppTheme.textTheme;
final Dio dio = DioService().dio;
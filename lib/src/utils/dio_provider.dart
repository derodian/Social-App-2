import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/monitoring/logger_dio_interceptor.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio();
  // * Only log network requests in debug mode
  if (kDebugMode) {
    dio.interceptors.add(LoggerDioInterceptor());
  }
  return dio;
}

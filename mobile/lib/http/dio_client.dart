import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dio;

  static Future<Dio> getInstance() async {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: 'http://192.168.0.114:83/api',
      ),
    );

    return _dio!;
  }
}

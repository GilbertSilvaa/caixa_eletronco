import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dio;

  static Future<Dio> getInstance() async {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: 'http://10.107.71.15:5000',
      ),
    );

    return _dio!;
  }
}

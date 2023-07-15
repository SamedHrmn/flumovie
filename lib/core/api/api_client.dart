import 'package:dio/dio.dart';

class ApiClient {
  factory ApiClient() {
    _instance ??= ApiClient._();
    return _instance!;
  }
  ApiClient._();

  static ApiClient? _instance;

  late final Dio _dio = Dio();

  Dio get dio => _dio;
}

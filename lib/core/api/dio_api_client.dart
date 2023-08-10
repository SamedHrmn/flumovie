// ignore_for_file: one_member_abstracts

import 'package:dio/dio.dart';
import 'package:flumovie/core/api/movie_api_uri.dart';

abstract interface class IApiClient {
  Future<T> fetch<T>({required MovieApiUri apiUri, required String param});
}

final class DioApiClient implements IApiClient {
  factory DioApiClient() {
    _instance ??= DioApiClient._();
    return _instance!;
  }
  DioApiClient._();

  static DioApiClient? _instance;

  late final Dio _dio = Dio();

  @override
  Future<T> fetch<T>({required MovieApiUri apiUri, required String param}) async {
    final response = await _dio.getUri<T>(apiUri.toUri(param));
    return response.data as T;
  }
}

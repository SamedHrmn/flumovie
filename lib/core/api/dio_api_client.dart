import 'package:dio/dio.dart';
import 'package:flumovie/core/api/i_api_client.dart';
import 'package:flumovie/core/api/movie_api_uri.dart';

final class DioApiClient implements IApiClient {
  factory DioApiClient() {
    _instance ??= DioApiClient._();
    return _instance!;
  }
  DioApiClient._();

  static DioApiClient? _instance;

  late final Dio _dio = Dio();

  @override
  Future<T> fetch<T>({required MovieApiUri apiUri, String? param}) async {
    final response = await _dio.getUri<T>(apiUri.toUri(param));
    return response.data as T;
  }
}

// ignore_for_file: one_member_abstracts

import 'package:flumovie/core/api/movie_api_uri.dart';

abstract interface class IApiClient {
  Future<T> fetch<T>({required MovieApiUri apiUri, String? param});
}

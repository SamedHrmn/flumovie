class MovieApiHelper {
  MovieApiHelper({required this.apiKey});

  final String apiKey;

  static const String _baseUrl = 'api.themoviedb.org';
  static const String _movieUrl = '3/movie';
  static const String _popularMovieUrl = '3/movie/popular';
  static const String _searchMovieUrl = '3/search/movie';

  Uri movie({required int movieId}) => _buildUri(
        endPoint: _movieUrl,
        pathParam: '$movieId',
        queryParameters: {'api_key': apiKey},
      );

  Uri popularMovie({int? page}) => _buildUri(
        endPoint: _popularMovieUrl,
        queryParameters: {'api_key': apiKey, 'page': page?.toString() ?? '1'},
      );

  Uri searchMovie({required String query}) => _buildUri(
        endPoint: _searchMovieUrl,
        queryParameters: {'api_key': apiKey, 'query': query},
      );

  Uri _buildUri({
    required String endPoint,
    Map<String, String>? queryParameters,
    String pathParam = '',
  }) {
    final path = pathParam.isEmpty ? endPoint : '$endPoint/$pathParam';
    print(Uri.https(_baseUrl, path, queryParameters));
    return Uri.https(_baseUrl, path, queryParameters);
  }
}

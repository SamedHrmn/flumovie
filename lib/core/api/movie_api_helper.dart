class MovieApiHelper {
  MovieApiHelper({required this.apiKey});

  final String apiKey;

  static const String _baseUrl = 'api.themoviedb.org';
  static const String _movieUrl = '3/movie';
  static const String _popularMovieUrl = '3/movie/popular';

  Uri movie({required int movieId}) => _buildUri(
        endPoint: _movieUrl,
        pathParam: '$movieId',
      );

  Uri popularMovie({int? page}) => _buildUri(
        endPoint: _popularMovieUrl,
        query: page,
      );

  Uri _buildUri({
    required String endPoint,
    Object? query,
    String pathParam = '',
  }) {
    print(Uri(
      scheme: 'https',
      host: _baseUrl,
      path: pathParam.isEmpty ? endPoint : '$endPoint/$pathParam',
      query: 'api_key=$apiKey${query ?? ''}',
    ));

    final _query = query != null ? '&$query' : '';

    return Uri(
      scheme: 'https',
      host: _baseUrl,
      path: pathParam.isEmpty ? endPoint : '$endPoint/$pathParam',
      query: 'api_key=$apiKey$_query',
    );
  }
}

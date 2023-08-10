import 'package:flutter_dotenv/flutter_dotenv.dart';

enum MovieApiUri {
  movie('3/movie'),
  popularMovie('3/movie/popular'),
  searchMovie('3/search/movie');

  const MovieApiUri(this.url);
  final String url;

  static const _baseUrl = 'api.themoviedb.org';

  Uri toUri(String param) {
    switch (this) {
      case MovieApiUri.movie:
        return _buildUri(
          endPoint: MovieApiUri.movie.url,
          pathParam: param,
        );
      case MovieApiUri.popularMovie:
        return _buildUri(
          endPoint: MovieApiUri.popularMovie.url,
          queryParameters: {'page': param},
        );

      case MovieApiUri.searchMovie:
        return _buildUri(
          endPoint: MovieApiUri.searchMovie.url,
          queryParameters: {'query': param},
        );
    }
  }

  Uri _buildUri({
    required String endPoint,
    Map<String, String>? queryParameters,
    String pathParam = '',
  }) {
    final path = pathParam.isEmpty ? endPoint : '$endPoint/$pathParam';

    final queryMap = {
      'api_key': dotenv.get('API_KEY'),
    }..addAll(queryParameters ?? {});
    print(Uri.https(_baseUrl, path, queryMap));
    return Uri.https(_baseUrl, path, queryMap);
  }
}

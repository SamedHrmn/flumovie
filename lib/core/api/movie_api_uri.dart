import 'package:flutter_dotenv/flutter_dotenv.dart';

enum MovieApiUri {
  movie('3/movie'),
  popularMovie('3/movie/popular'),
  searchMovie('3/search/movie'),
  upcomingMovie('3/movie/upcoming');

  const MovieApiUri(this.url);
  final String url;

  static const _baseUrl = 'api.themoviedb.org';

  Uri toUri(String? param) {
    switch (this) {
      case MovieApiUri.movie:
        assert(param != null, 'Movie param cant be null');
        return _buildUri(
          endPoint: MovieApiUri.movie.url,
          pathParam: param!,
        );
      case MovieApiUri.popularMovie:
        assert(param != null, 'Popular movie param cant be null');
        return _buildUri(
          endPoint: MovieApiUri.popularMovie.url,
          queryParameters: {'page': param!},
        );

      case MovieApiUri.searchMovie:
        assert(param != null, 'Search movie param cant be null');
        return _buildUri(
          endPoint: MovieApiUri.searchMovie.url,
          queryParameters: {'query': param!},
        );
      case MovieApiUri.upcomingMovie:
        return _buildUri(
          endPoint: MovieApiUri.upcomingMovie.url,
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

    return Uri.https(_baseUrl, path, queryMap);
  }
}

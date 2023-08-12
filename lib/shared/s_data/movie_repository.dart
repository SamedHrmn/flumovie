import 'package:flumovie/core/api/i_api_client.dart';
import 'package:flumovie/core/api/movie_api_uri.dart';
import 'package:flumovie/features/detail/application/movie_detail_dto.dart';
import 'package:flumovie/features/detail/domain/movie_detail.dart';
import 'package:flumovie/features/home/popular/application/popular_movie_dto.dart';
import 'package:flumovie/features/home/popular/domain/popular_movie.dart';
import 'package:flumovie/features/search/application/movie_search_dto.dart';
import 'package:flumovie/features/search/domain/movie_search.dart';
import 'package:flumovie/shared/s_data/i_movie_repository.dart';

class MovieRepository implements IMovieRepository {
  MovieRepository({required this.client});

  final IApiClient client;

  @override
  Future<PopularMovieDTO?> getPopularMovies({int page = 1, int limit = 8}) async {
    try {
      final popularMovieResponse = await client.fetch<Map<String, dynamic>>(
        apiUri: MovieApiUri.popularMovie,
        param: page.toString(),
      );

      if (popularMovieResponse.isEmpty) {
        return null;
      }

      return PopularMovieDTO.fromDomain(PopularMovie.fromJson(popularMovieResponse), limit: limit);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<MovieDetailDTO?> getMovieDetail({required int movieId}) async {
    final movieResponse = await client.fetch<Map<String, dynamic>>(
      apiUri: MovieApiUri.movie,
      param: movieId.toString(),
    );

    if (movieResponse.isEmpty) {
      return null;
    }

    return MovieDetailDTO.fromDomain(
      MovieDetail.fromJson(movieResponse),
    );
  }

  @override
  Future<MovieSearchDTO?> searchMovie({required String title}) async {
    try {
      final searchResponse = await client.fetch<Map<String, dynamic>>(
        apiUri: MovieApiUri.searchMovie,
        param: title,
      );

      if (searchResponse.isEmpty) {
        return null;
      }

      return MovieSearchDTO.fromDomain(
        MovieSearch.fromJson(searchResponse),
      );
    } catch (e) {
      return null;
    }
  }
}

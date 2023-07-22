import 'package:flumovie/core/api/api_client.dart';
import 'package:flumovie/core/api/movie_api_helper.dart';
import 'package:flumovie/features/detail/application/movie_detail_dto.dart';
import 'package:flumovie/features/detail/domain/movie_detail.dart';

import 'package:flumovie/features/search/application/movie_search_dto.dart';
import 'package:flumovie/features/search/domain/movie_search.dart';
import 'package:flumovie/shared/s_data/i_movie_repository.dart';

import '../../features/home/popular/application/popular_movie_dto.dart';
import '../../features/home/popular/domain/popular_movie.dart';

class DioMovieRepository implements IMovieRepository {
  DioMovieRepository({required this.apiHelper, required this.client});

  final ApiClient client;
  final MovieApiHelper apiHelper;

  @override
  Future<PopularMovieDTO?> getPopularMovies({int page = 1, int limit = 8}) async {
    try {
      final popularMovieResponse = await client.dio.getUri<Map<String, dynamic>>(
        apiHelper.popularMovie(page: page),
      );

      return PopularMovieDTO.fromDomain(PopularMovie.fromJson(popularMovieResponse.data!), limit: limit);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<MovieDetailDTO?> getMovieDetail({required int movieId}) async {
    final movieResponse = await client.dio.getUri<Map<String, dynamic>>(
      apiHelper.movie(movieId: movieId),
    );

    if (movieResponse.data == null) {
      return null;
    }

    return MovieDetailDTO.fromDomain(
      MovieDetail.fromJson(movieResponse.data!),
    );
  }

  @override
  Future<MovieSearchDTO?> searchMovie({required String title}) async {
    try {
      final searchResponse = await client.dio.getUri<Map<String, dynamic>>(apiHelper.searchMovie(query: title));

      if (searchResponse.data == null) {
        return null;
      }

      return MovieSearchDTO.fromDomain(
        MovieSearch.fromJson(searchResponse.data!),
      );
    } catch (e) {
      return null;
    }
  }
}

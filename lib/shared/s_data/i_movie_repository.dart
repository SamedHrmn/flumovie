import 'package:flumovie/features/detail/domain/movie_detail_result.dart';

import 'package:flumovie/features/popular/domain/popular_movie_result.dart';

abstract interface class IMovieRepository {
  Future<MovieDetailResult> getMovieDetail({required int movieId});
  Future<PopularMoviesResult> getPopularMovies({int page = 1, int limit = 8});
}

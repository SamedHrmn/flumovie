import 'package:flumovie/features/movie/domain/movie.dart';
import 'package:flumovie/features/movie/domain/popular_movie_result.dart';

abstract interface class IMovieRepository {
  Future<Movie?> getMovie({required int movieId});
  Future<PopularMoviesResult> getPopularMovies({int page = 1});
}

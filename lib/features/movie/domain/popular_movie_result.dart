import 'package:flumovie/features/movie/domain/popular_movie.dart';

class PopularMoviesResult {
  PopularMoviesResult(this.movies, {this.error});
  final PopularMovie? movies;
  final String? error;
}

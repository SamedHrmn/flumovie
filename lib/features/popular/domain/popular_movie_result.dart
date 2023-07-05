import 'package:flumovie/features/popular/application/popular_movie_dto.dart';

class PopularMoviesResult {
  PopularMoviesResult(this.movies, {this.error});
  final PopularMovieDTO? movies;
  final String? error;
}

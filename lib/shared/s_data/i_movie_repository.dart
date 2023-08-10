import 'package:flumovie/features/detail/application/movie_detail_dto.dart';
import 'package:flumovie/features/home/popular/application/popular_movie_dto.dart';
import 'package:flumovie/features/search/application/movie_search_dto.dart';

abstract interface class IMovieRepository {
  Future<MovieDetailDTO?> getMovieDetail({required int movieId});
  Future<PopularMovieDTO?> getPopularMovies({int page = 1, int limit = 8});
  Future<MovieSearchDTO?> searchMovie({required String title});
}

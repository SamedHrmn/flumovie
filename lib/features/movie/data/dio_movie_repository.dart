import 'package:flumovie/api/api_client.dart';
import 'package:flumovie/features/movie/data/i_movie_repository.dart';
import 'package:flumovie/features/movie/domain/movie.dart';
import 'package:flumovie/features/movie/domain/popular_movie_result.dart';

class DioMovieRepository implements IMovieRepository {
  DioMovieRepository({required this.client});

  final ApiClient client;

  @override
  Future<Movie?> getMovie({required int movieId}) async {
    return Movie();
  }

  @override
  Future<PopularMoviesResult> getPopularMovies({int page = 1}) async {
    return PopularMoviesResult(null);
  }
}

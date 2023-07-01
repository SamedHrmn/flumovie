import 'package:flumovie/api/api_client.dart';
import 'package:flumovie/api/movie_api_helper.dart';
import 'package:flumovie/features/movie/application/popular_movie_dto.dart';
import 'package:flumovie/features/movie/data/i_movie_repository.dart';
import 'package:flumovie/features/movie/domain/movie.dart';
import 'package:flumovie/features/movie/domain/popular_movie.dart';
import 'package:flumovie/features/movie/domain/popular_movie_result.dart';

class DioMovieRepository implements IMovieRepository {
  DioMovieRepository({required this.apiHelper, required this.client});

  final ApiClient client;
  final MovieApiHelper apiHelper;

  @override
  Future<Movie?> getMovie({required int movieId}) async {
    return Movie();
  }

  @override
  Future<PopularMoviesResult> getPopularMovies({int page = 1}) async {
    try {
      final popularMovieResponse = await client.dio.getUri<Map<String, dynamic>>(
        apiHelper.popularMovie(page: page),
      );

      return PopularMoviesResult(
        PopularMovieDTO.fromDomain(PopularMovie.fromJson(popularMovieResponse.data!)),
      );
    } catch (e) {
      return PopularMoviesResult(null, error: e.toString());
    }
  }
}

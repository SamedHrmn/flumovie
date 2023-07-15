import 'package:flumovie/core/api/api_client.dart';
import 'package:flumovie/core/api/movie_api_helper.dart';
import 'package:flumovie/features/detail/application/movie_detail_dto.dart';
import 'package:flumovie/features/detail/domain/movie_detail.dart';
import 'package:flumovie/features/detail/domain/movie_detail_result.dart';
import 'package:flumovie/features/popular/application/popular_movie_dto.dart';
import 'package:flumovie/features/popular/domain/popular_movie.dart';
import 'package:flumovie/features/popular/domain/popular_movie_result.dart';
import 'package:flumovie/shared/s_data/i_movie_repository.dart';

class DioMovieRepository implements IMovieRepository {
  DioMovieRepository({required this.apiHelper, required this.client});

  final ApiClient client;
  final MovieApiHelper apiHelper;

  @override
  Future<PopularMoviesResult> getPopularMovies({int page = 1, int limit = 8}) async {
    try {
      final popularMovieResponse = await client.dio.getUri<Map<String, dynamic>>(
        apiHelper.popularMovie(page: page),
      );

      return PopularMoviesResult(
        PopularMovieDTO.fromDomain(PopularMovie.fromJson(popularMovieResponse.data!), limit: limit),
      );
    } catch (e) {
      return PopularMoviesResult(null, error: e.toString());
    }
  }

  @override
  Future<MovieDetailResult> getMovieDetail({required int movieId}) async {
    final movieResponse = await client.dio.getUri<Map<String, dynamic>>(
      apiHelper.movie(movieId: movieId),
    );

    if (movieResponse.data == null) {
      return MovieDetailResult(null, error: 'Detail error');
    }

    return MovieDetailResult(
      MovieDetailDTO.fromDomain(
        MovieDetail.fromJson(movieResponse.data!),
      ),
    );
  }
}

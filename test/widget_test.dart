// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:developer';

import 'package:flumovie/core/api/api_client.dart';
import 'package:flumovie/core/api/movie_api_helper.dart';
import 'package:flumovie/features/detail/application/movie_detail_dto.dart';
import 'package:flumovie/features/detail/domain/movie_detail.dart';

import 'package:flumovie/features/popular/application/popular_movie_dto.dart';
import 'package:flumovie/features/popular/domain/popular_movie.dart';

import 'package:flumovie/shared/s_data/i_movie_repository.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_test/flutter_test.dart';

class MockMovieRepository implements IMovieRepository {
  MockMovieRepository({
    required this.apiClient,
    required this.apiHelper,
  });
  final ApiClient apiClient;
  final MovieApiHelper apiHelper;

  @override
  Future<MovieDetailDTO?> getMovieDetail({required int movieId}) async {
    try {
      final movieResponse = await apiClient.dio.getUri<Map<String, dynamic>>(
        apiHelper.movie(movieId: movieId),
      );

      expect(movieResponse.data, isNotNull, reason: 'Movie response data is null');
      log(movieResponse.data!.toString(), name: 'Movie data');

      return MovieDetailDTO(
        movieDetail: MovieDetail.fromJson(movieResponse.data!),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<PopularMovieDTO?> getPopularMovies({int page = 1, int limit = 8}) async {
    try {
      final popularMovieResponse = await apiClient.dio.getUri<Map<String, dynamic>>(
        apiHelper.popularMovie(page: page),
      );

      expect(popularMovieResponse.data, isNotNull);
      log(popularMovieResponse.data!.toString(), name: 'Popular movie data');

      return PopularMovieDTO.fromDomain(PopularMovie.fromJson(popularMovieResponse.data!));
    } catch (e) {
      return null;
    }
  }
}

void main() async {
  await dotenv.load();

  final apiHelper = MovieApiHelper(apiKey: dotenv.get('API_KEY'));

  test('Movie Test', () async {
    final mockMovieRepository = MockMovieRepository(
      apiClient: ApiClient(),
      apiHelper: apiHelper,
    );
    await mockMovieRepository.getMovieDetail(movieId: 5353);
  });

  test('Popular Movie Test', () async {
    final mockMovieRepository = MockMovieRepository(
      apiClient: ApiClient(),
      apiHelper: apiHelper,
    );
    final popularMovieDTO = await mockMovieRepository.getPopularMovies();
    expect(popularMovieDTO, isNotNull);
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:developer';

import 'package:flumovie/core/api/dio_api_client.dart';
import 'package:flumovie/core/api/i_api_client.dart';
import 'package:flumovie/core/api/movie_api_uri.dart';
import 'package:flumovie/features/detail/application/movie_detail_dto.dart';
import 'package:flumovie/features/detail/domain/movie_detail.dart';
import 'package:flumovie/features/home/popular/application/popular_movie_dto.dart';
import 'package:flumovie/features/home/popular/domain/popular_movie.dart';
import 'package:flumovie/features/home/upcoming/application/upcoming_movies_dto.dart';
import 'package:flumovie/features/home/upcoming/domain/upcoming_movies.dart';

import 'package:flumovie/features/search/application/movie_search_dto.dart';
import 'package:flumovie/features/search/domain/movie_search.dart';

import 'package:flumovie/shared/s_data/i_movie_repository.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_test/flutter_test.dart';

class MockMovieRepository implements IMovieRepository {
  MockMovieRepository({
    required this.apiClient,
  });
  final IApiClient apiClient;

  @override
  Future<MovieDetailDTO?> getMovieDetail({required int movieId}) async {
    try {
      final movieResponse = await apiClient.fetch<Map<String, dynamic>>(
        apiUri: MovieApiUri.movie,
        param: movieId.toString(),
      );

      expect(movieResponse, isNotEmpty, reason: 'Movie response data is empty');
      log(movieResponse.toString(), name: 'Movie data');

      return MovieDetailDTO(
        movieDetail: MovieDetail.fromJson(movieResponse),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<PopularMovieDTO?> getPopularMovies({int page = 1, int limit = 8}) async {
    try {
      final popularMovieResponse = await apiClient.fetch<Map<String, dynamic>>(
        apiUri: MovieApiUri.popularMovie,
        param: page.toString(),
      );

      expect(popularMovieResponse, isNotEmpty);
      log(popularMovieResponse.toString(), name: 'Popular movie data');

      return PopularMovieDTO.fromDomain(PopularMovie.fromJson(popularMovieResponse));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<MovieSearchDTO?> searchMovie({required String title}) async {
    try {
      final searchResponse = await apiClient.fetch<Map<String, dynamic>>(
        apiUri: MovieApiUri.searchMovie,
        param: title,
      );

      expect(searchResponse, isNotNull);
      log(searchResponse.toString(), name: 'Search movie data for $title');

      return MovieSearchDTO.fromDomain(
        MovieSearch.fromJson(searchResponse),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UpcomingMoviesDTO?> upcomingMovies({int limit = 8}) async {
    try {
      final upcomingResponse = await apiClient.fetch<Map<String, dynamic>>(apiUri: MovieApiUri.upcomingMovie);

      expect(upcomingResponse, isNotEmpty);
      log(upcomingResponse.toString(), name: 'Upcoming movie data');

      return UpcomingMoviesDTO.fromDomain(
        upcomingMovies: UpcomingMovies.fromJson(upcomingResponse),
        limit: limit,
      );
    } catch (e) {
      return null;
    }
  }
}

void main() async {
  await dotenv.load();

  test('Movie Test', () async {
    final mockMovieRepository = MockMovieRepository(
      apiClient: DioApiClient(),
    );
    await mockMovieRepository.getMovieDetail(movieId: 624860);
  });

  test('Popular Movie Test', () async {
    final mockMovieRepository = MockMovieRepository(
      apiClient: DioApiClient(),
    );
    final popularMovieDTO = await mockMovieRepository.getPopularMovies();
    expect(popularMovieDTO, isNotNull);
  });

  test('Search Movie Test For Success', () async {
    final mockMovieRepository = MockMovieRepository(
      apiClient: DioApiClient(),
    );
    final searchMovieDTO = await mockMovieRepository.searchMovie(title: 'Lord of the Rings: Two Towers');
    expect(searchMovieDTO!.movieSearchDetails, isNotEmpty);
  });

  test('Search Movie Test For Not Found', () async {
    final mockMovieRepository = MockMovieRepository(
      apiClient: DioApiClient(),
    );
    final searchMovieDTO = await mockMovieRepository.searchMovie(title: '');
    expect(searchMovieDTO!.movieSearchDetails, isEmpty);
  });

  test('Upcoming Movie Test', () async {
    final mockMovieRepository = MockMovieRepository(
      apiClient: DioApiClient(),
    );
    final upcomingMoviesDTO = await mockMovieRepository.upcomingMovies();
    expect(upcomingMoviesDTO!.upcomingMovies, isNotEmpty);
  });
}

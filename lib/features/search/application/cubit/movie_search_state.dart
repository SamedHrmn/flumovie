import 'package:flumovie/features/search/application/movie_search_dto.dart';
import 'package:flutter/foundation.dart';

enum MovieSearchStatus { initial, loading, success, noResult, failure }

@immutable
class MovieSearchState {
  const MovieSearchState({
    required this.status,
    this.queryString,
    this.movieSearchDTO,
  });

  final MovieSearchDTO? movieSearchDTO;
  final MovieSearchStatus status;
  final String? queryString;

  MovieSearchState copyWith({
    MovieSearchDTO? movieSearchDTO,
    MovieSearchStatus? status,
    String? queryString,
  }) {
    return MovieSearchState(
      movieSearchDTO: movieSearchDTO ?? this.movieSearchDTO,
      status: status ?? this.status,
      queryString: queryString ?? this.queryString,
    );
  }
}

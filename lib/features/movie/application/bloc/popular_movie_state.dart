// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flumovie/features/movie/application/popular_movie_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_movie_state.g.dart';

enum PopularMovieStatus { initial, loading, success, failure }

@immutable
@JsonSerializable()
class PopularMovieState {
  const PopularMovieState({
    required this.status,
    this.popularMovieDTO,
  });

  final PopularMovieStatus status;
  final PopularMovieDTO? popularMovieDTO;

  PopularMovieState copyWith({
    PopularMovieStatus? status,
    PopularMovieDTO? popularMovieDTO,
  }) {
    return PopularMovieState(
      status: status ?? this.status,
      popularMovieDTO: popularMovieDTO ?? this.popularMovieDTO,
    );
  }

  @override
  bool operator ==(covariant PopularMovieState other) {
    if (identical(this, other)) return true;

    return other.status == status && other.popularMovieDTO == popularMovieDTO;
  }

  @override
  int get hashCode => status.hashCode ^ popularMovieDTO.hashCode;

  factory PopularMovieState.fromJson(Map<String, dynamic> json) => _$PopularMovieStateFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMovieStateToJson(this);
}

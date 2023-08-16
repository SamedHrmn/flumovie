import 'package:flumovie/features/home/popular/application/popular_movie_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_movie_state.g.dart';

enum PopularMovieStatus { initial, loading, success, failure }

@immutable
@JsonSerializable()
class PopularMovieState {
  const PopularMovieState({
    required this.status,
    this.popularMovieDTO,
  });

  factory PopularMovieState.fromJson(Map<String, dynamic> json) => _$PopularMovieStateFromJson(json);

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

  Map<String, dynamic> toJson() => _$PopularMovieStateToJson(this);
}

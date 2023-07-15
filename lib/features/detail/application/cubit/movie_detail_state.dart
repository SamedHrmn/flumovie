// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flumovie/features/detail/application/movie_detail_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_state.g.dart';

enum MovieDetailStatus { initial, loading, success, failure }

@JsonSerializable()
@immutable
class MovieDetailState {
  const MovieDetailState({
    required this.status,
    this.movieDetailDTO,
  });

  final MovieDetailDTO? movieDetailDTO;
  final MovieDetailStatus status;

  MovieDetailState copyWith({
    MovieDetailDTO? movieDetailDTO,
    MovieDetailStatus? status,
  }) {
    return MovieDetailState(
      movieDetailDTO: movieDetailDTO ?? this.movieDetailDTO,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(covariant MovieDetailState other) {
    if (identical(this, other)) return true;

    return other.movieDetailDTO == movieDetailDTO && other.status == status;
  }

  @override
  int get hashCode => movieDetailDTO.hashCode ^ status.hashCode;

  factory MovieDetailState.fromJson(Map<String, dynamic> json) => _$MovieDetailStateFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailStateToJson(this);
}

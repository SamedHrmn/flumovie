// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flumovie/features/detail/domain/movie_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorites_state.g.dart';

@JsonSerializable()
@immutable
class FavoritesState {
  const FavoritesState({required this.favorites});

  final List<MovieDetail> favorites;

  FavoritesState copyWith({
    List<MovieDetail>? favorites,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
    );
  }

  factory FavoritesState.fromJson(Map<String, dynamic> json) => _$FavoritesStateFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritesStateToJson(this);
}

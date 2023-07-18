// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritesState _$FavoritesStateFromJson(Map<String, dynamic> json) =>
    FavoritesState(
      favorites: (json['favorites'] as List<dynamic>)
          .map((e) => MovieDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoritesStateToJson(FavoritesState instance) =>
    <String, dynamic>{
      'favorites': instance.favorites,
    };

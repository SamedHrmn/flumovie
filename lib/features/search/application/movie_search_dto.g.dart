// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSearchDTO _$MovieSearchDTOFromJson(Map<String, dynamic> json) =>
    MovieSearchDTO(
      movieSearch: json['movieSearch'] == null
          ? null
          : MovieSearch.fromJson(json['movieSearch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieSearchDTOToJson(MovieSearchDTO instance) =>
    <String, dynamic>{
      'movieSearch': instance.movieSearch,
    };

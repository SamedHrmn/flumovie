// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSearchDTO _$MovieSearchDTOFromJson(Map<String, dynamic> json) =>
    MovieSearchDTO(
      movieSearchDetails: (json['movieSearchDetails'] as List<dynamic>)
          .map((e) => MovieSearchDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieSearchDTOToJson(MovieSearchDTO instance) =>
    <String, dynamic>{
      'movieSearchDetails': instance.movieSearchDetails,
    };

MovieSearchDetail _$MovieSearchDetailFromJson(Map<String, dynamic> json) =>
    MovieSearchDetail(
      id: json['id'] as int?,
      posterPath: json['posterPath'] as String?,
    );

Map<String, dynamic> _$MovieSearchDetailToJson(MovieSearchDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'posterPath': instance.posterPath,
    };

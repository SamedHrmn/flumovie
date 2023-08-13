// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_movies_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingMoviesDTO _$UpcomingMoviesDTOFromJson(Map<String, dynamic> json) =>
    UpcomingMoviesDTO(
      upcomingMovies: (json['upcomingMovies'] as List<dynamic>)
          .map((e) => UpcomingMoviesDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpcomingMoviesDTOToJson(UpcomingMoviesDTO instance) =>
    <String, dynamic>{
      'upcomingMovies': instance.upcomingMovies,
    };

UpcomingMoviesDetail _$UpcomingMoviesDetailFromJson(
        Map<String, dynamic> json) =>
    UpcomingMoviesDetail(
      id: json['id'] as int?,
      backdropPath: json['backdropPath'] as String?,
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
    );

Map<String, dynamic> _$UpcomingMoviesDetailToJson(
        UpcomingMoviesDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'backdropPath': instance.backdropPath,
      'releaseDate': instance.releaseDate?.toIso8601String(),
    };

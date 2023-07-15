// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularMovieDTO _$PopularMovieDTOFromJson(Map<String, dynamic> json) =>
    PopularMovieDTO(
      page: json['page'] as int?,
      popularMovies: (json['popularMovies'] as List<dynamic>?)
          ?.map((e) => PopularMovieDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PopularMovieDTOToJson(PopularMovieDTO instance) =>
    <String, dynamic>{
      'page': instance.page,
      'popularMovies': instance.popularMovies,
    };

PopularMovieDetail _$PopularMovieDetailFromJson(Map<String, dynamic> json) =>
    PopularMovieDetail(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$PopularMovieDetailToJson(PopularMovieDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };

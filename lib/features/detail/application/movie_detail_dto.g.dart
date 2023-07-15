// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailDTO _$MovieDetailDTOFromJson(Map<String, dynamic> json) =>
    MovieDetailDTO(
      movieDetail: json['movieDetail'] == null
          ? null
          : MovieDetail.fromJson(json['movieDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailDTOToJson(MovieDetailDTO instance) =>
    <String, dynamic>{
      'movieDetail': instance.movieDetail,
    };

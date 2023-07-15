// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailState _$MovieDetailStateFromJson(Map<String, dynamic> json) =>
    MovieDetailState(
      status: $enumDecode(_$MovieDetailStatusEnumMap, json['status']),
      movieDetailDTO: json['movieDetailDTO'] == null
          ? null
          : MovieDetailDTO.fromJson(
              json['movieDetailDTO'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailStateToJson(MovieDetailState instance) =>
    <String, dynamic>{
      'movieDetailDTO': instance.movieDetailDTO,
      'status': _$MovieDetailStatusEnumMap[instance.status]!,
    };

const _$MovieDetailStatusEnumMap = {
  MovieDetailStatus.initial: 'initial',
  MovieDetailStatus.loading: 'loading',
  MovieDetailStatus.success: 'success',
  MovieDetailStatus.failure: 'failure',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movie_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularMovieState _$PopularMovieStateFromJson(Map<String, dynamic> json) =>
    PopularMovieState(
      status: $enumDecode(_$PopularMovieStatusEnumMap, json['status']),
      popularMovieDTO: json['popularMovieDTO'] == null
          ? null
          : PopularMovieDTO.fromJson(
              json['popularMovieDTO'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PopularMovieStateToJson(PopularMovieState instance) =>
    <String, dynamic>{
      'status': _$PopularMovieStatusEnumMap[instance.status]!,
      'popularMovieDTO': instance.popularMovieDTO,
    };

const _$PopularMovieStatusEnumMap = {
  PopularMovieStatus.initial: 'initial',
  PopularMovieStatus.loading: 'loading',
  PopularMovieStatus.success: 'success',
  PopularMovieStatus.failure: 'failure',
};

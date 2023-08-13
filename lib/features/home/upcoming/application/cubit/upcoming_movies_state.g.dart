// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_movies_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingMoviesState _$UpcomingMoviesStateFromJson(Map<String, dynamic> json) =>
    UpcomingMoviesState(
      status: $enumDecode(_$UpcomingMoviesStatusEnumMap, json['status']),
      upcomingMoviesDTO: json['upcomingMoviesDTO'] == null
          ? null
          : UpcomingMoviesDTO.fromJson(
              json['upcomingMoviesDTO'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpcomingMoviesStateToJson(
        UpcomingMoviesState instance) =>
    <String, dynamic>{
      'upcomingMoviesDTO': instance.upcomingMoviesDTO,
      'status': _$UpcomingMoviesStatusEnumMap[instance.status]!,
    };

const _$UpcomingMoviesStatusEnumMap = {
  UpcomingMoviesStatus.initial: 'initial',
  UpcomingMoviesStatus.loading: 'loading',
  UpcomingMoviesStatus.success: 'success',
  UpcomingMoviesStatus.failure: 'failure',
};

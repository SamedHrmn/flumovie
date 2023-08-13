import 'package:flumovie/features/home/upcoming/domain/upcoming_movies.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upcoming_movies_dto.g.dart';

@immutable
@JsonSerializable()
class UpcomingMoviesDTO {
  const UpcomingMoviesDTO({required this.upcomingMovies});

  factory UpcomingMoviesDTO.fromJson(Map<String, dynamic> json) => _$UpcomingMoviesDTOFromJson(json);
  factory UpcomingMoviesDTO.fromDomain({required UpcomingMovies upcomingMovies, required int limit}) {
    final upcomings = <UpcomingMoviesDetail>[];

    if (upcomingMovies.results != null) {
      for (final element in upcomingMovies.results!) {
        if (upcomings.length == limit) break;
        final detailModel = UpcomingMoviesDetail(
          id: element.id,
          backdropPath: element.backdropPath,
          releaseDate: element.releaseDate,
        );
        upcomings.add(detailModel);
      }
    }

    return UpcomingMoviesDTO(upcomingMovies: upcomings);
  }

  final List<UpcomingMoviesDetail> upcomingMovies;

  Map<String, dynamic> toJson() => _$UpcomingMoviesDTOToJson(this);
}

@immutable
@JsonSerializable()
final class UpcomingMoviesDetail {
  const UpcomingMoviesDetail({this.id, this.backdropPath, this.releaseDate});

  factory UpcomingMoviesDetail.fromJson(Map<String, dynamic> json) => _$UpcomingMoviesDetailFromJson(json);

  final int? id;
  final String? backdropPath;
  final DateTime? releaseDate;

  Map<String, dynamic> toJson() => _$UpcomingMoviesDetailToJson(this);
}

import 'package:json_annotation/json_annotation.dart' show JsonKey, JsonSerializable;

part 'popular_movie.g.dart';

@JsonSerializable()
final class PopularMovie {
  const PopularMovie({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });
  factory PopularMovie.fromJson(Map<String, Object?> json) => _$PopularMovieFromJson(json);

  final int? page;
  final List<_Results>? results;

  @JsonKey(name: 'total_pages')
  final int? totalPages;

  @JsonKey(name: 'total_results')
  final int? totalResults;
}

@JsonSerializable()
class _Results {
  const _Results({
    this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  factory _Results.fromJson(Map<String, Object?> json) => _$ResultsFromJson(json);

  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  final int? id;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'original_title')
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final String? title;
  final bool? video;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
}

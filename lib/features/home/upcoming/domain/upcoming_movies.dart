import 'package:json_annotation/json_annotation.dart';

part 'upcoming_movies.g.dart';

@JsonSerializable()
class UpcomingMovies {
  UpcomingMovies({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory UpcomingMovies.fromJson(Map<String, dynamic> json) => _$UpcomingMoviesFromJson(json);
  @JsonKey(name: 'dates')
  final Dates? dates;
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'results')
  final List<Result>? results;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'total_results')
  final int? totalResults;

  Map<String, dynamic> toJson() => _$UpcomingMoviesToJson(this);
}

@JsonSerializable()
class Dates {
  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);
  @JsonKey(name: 'maximum')
  final DateTime? maximum;
  @JsonKey(name: 'minimum')
  final DateTime? minimum;

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}

@JsonSerializable()
class Result {
  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
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

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  @JsonKey(name: 'adult')
  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'original_language')
  final OriginalLanguage? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'popularity')
  final double? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'video')
  final bool? video;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

enum OriginalLanguage {
  @JsonValue('en')
  EN,
  @JsonValue('fr')
  FR,
  @JsonValue('ja')
  JA,
  @JsonValue('nl')
  NL
}
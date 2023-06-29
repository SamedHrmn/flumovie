import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_movie.freezed.dart';
part 'popular_movie.g.dart';

@freezed
class PopularMovie with _$PopularMovie {
  const factory PopularMovie({
    int? page,
    List<_Results>? results,
    int? totalPages,
    int? totalResults,
  }) = _PopularMovie;

  factory PopularMovie.fromJson(Map<String, Object?> json) => _$PopularMovieFromJson(json);
}

@freezed
class _Results with _$_Results {
  const factory _Results({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    required int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) = __Resullts;

  factory _Results.fromJson(Map<String, Object?> json) => _$_ResultsFromJson(json);
}

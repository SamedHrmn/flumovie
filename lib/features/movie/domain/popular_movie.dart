import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_movie.freezed.dart';
part 'popular_movie.g.dart';

@freezed
class PopularMovie with _$PopularMovie {
  const factory PopularMovie({
    int? page,
    List<_Results>? results,
    int? total_pages,
    int? total_results,
  }) = _PopularMovie;

  factory PopularMovie.fromJson(Map<String, Object?> json) => _$PopularMovieFromJson(json);
}

@freezed
class _Results with _$_Results {
  const factory _Results({
    bool? adult,
    String? backdrop_path,
    List<int>? genre_ids,
    required int? id,
    String? original_language,
    String? original_title,
    String? overview,
    double? popularity,
    String? poster_path,
    String? release_date,
    String? title,
    bool? video,
    double? vote_average,
    int? vote_count,
  }) = __Resullts;

  factory _Results.fromJson(Map<String, Object?> json) => _$_ResultsFromJson(json);
}

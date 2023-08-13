import 'package:flumovie/features/search/domain/movie_search.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_search_dto.g.dart';

@JsonSerializable()
class MovieSearchDTO {
  MovieSearchDTO({required this.movieSearchDetails});

  factory MovieSearchDTO.fromJson(Map<String, dynamic> json) => _$MovieSearchDTOFromJson(json);

  factory MovieSearchDTO.fromDomain(MovieSearch movieSearch) {
    final result = movieSearch.results;
    if (result == null || result.isEmpty == true) {
      return MovieSearchDTO(movieSearchDetails: []);
    }

    final details = <MovieSearchDetail>[];

    for (final element in result) {
      final model = MovieSearchDetail(id: element.id, posterPath: element.posterPath);
      details.add(model);
    }

    return MovieSearchDTO(movieSearchDetails: details);
  }

  final List<MovieSearchDetail> movieSearchDetails;

  Map<String, dynamic> toJson() => _$MovieSearchDTOToJson(this);
}

@JsonSerializable()
final class MovieSearchDetail {
  const MovieSearchDetail({this.id, this.posterPath});

  factory MovieSearchDetail.fromJson(Map<String, dynamic> json) => _$MovieSearchDetailFromJson(json);

  final int? id;
  final String? posterPath;

  Map<String, dynamic> toJson() => _$MovieSearchDetailToJson(this);
}

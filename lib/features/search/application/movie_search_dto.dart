import 'package:flumovie/features/search/domain/movie_search.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_search_dto.g.dart';

@JsonSerializable()
class MovieSearchDTO {
  MovieSearchDTO({required this.movieSearch});

  factory MovieSearchDTO.fromJson(Map<String, dynamic> json) => _$MovieSearchDTOFromJson(json);

  factory MovieSearchDTO.fromDomain(MovieSearch movieSearch) => MovieSearchDTO(
        movieSearch: movieSearch,
      );

  final MovieSearch? movieSearch;

  Map<String, dynamic> toJson() => _$MovieSearchDTOToJson(this);
}

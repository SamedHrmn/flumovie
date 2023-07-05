import 'package:flumovie/features/popular/domain/popular_movie.dart';
import 'package:json_annotation/json_annotation.dart';
part 'popular_movie_dto.g.dart';

@JsonSerializable()
class PopularMovieDTO {
  const PopularMovieDTO({
    required this.page,
    required this.popularMovies,
  });
  factory PopularMovieDTO.fromJson(Map<String, dynamic> json) => _$PopularMovieDTOFromJson(json);

  factory PopularMovieDTO.fromDomain(PopularMovie popularMovie) {
    return PopularMovieDTO(
      page: popularMovie.page,
      popularMovies: popularMovie.results
          ?.map(
            (e) => _PopularMovieDetail(
              id: e.id,
              title: e.title,
              description: e.overview,
              imageUrl: e.posterPath,
            ),
          )
          .toList(),
    );
  }
  final int? page;
  final List<_PopularMovieDetail>? popularMovies;

  Map<String, dynamic> toJson() => _$PopularMovieDTOToJson(this);
}

@JsonSerializable()
class _PopularMovieDetail {
  _PopularMovieDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
  factory _PopularMovieDetail.fromJson(Map<String, dynamic> json) => _$PopularMovieDetailFromJson(json);
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;

  Map<String, dynamic> toJson() => _$PopularMovieDetailToJson(this);
}

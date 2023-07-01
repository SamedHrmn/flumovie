import 'package:flumovie/features/movie/domain/popular_movie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_movie_dto.g.dart';

@JsonSerializable()
class PopularMovieDTO {
  factory PopularMovieDTO.fromJson(Map<String, dynamic> json) => _$PopularMovieDTOFromJson(json);
  const PopularMovieDTO({
    required this.page,
    required this.popularMovies,
  });

  factory PopularMovieDTO.fromDomain(PopularMovie popularMovie) {
    return PopularMovieDTO(
      page: popularMovie.page,
      popularMovies: popularMovie.results
          ?.map(
            (e) => _PopularMovieDetail(
              id: e.id,
              title: e.title,
              description: e.overview,
              imageUrl: e.poster_path,
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
  factory _PopularMovieDetail.fromJson(Map<String, dynamic> json) => _$PopularMovieDetailFromJson(json);
  _PopularMovieDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;

  Map<String, dynamic> toJson() => _$PopularMovieDetailToJson(this);
}

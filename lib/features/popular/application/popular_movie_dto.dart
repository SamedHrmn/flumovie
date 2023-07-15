import 'package:flumovie/features/popular/domain/popular_movie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_movie_dto.g.dart';

@JsonSerializable()
final class PopularMovieDTO {
  const PopularMovieDTO({
    required this.page,
    required this.popularMovies,
  });
  factory PopularMovieDTO.fromJson(Map<String, dynamic> json) => _$PopularMovieDTOFromJson(json);

  factory PopularMovieDTO.fromDomain(PopularMovie popularMovie, {int limit = 8}) {
    final limitedPopularMovies = <PopularMovieDetail>[];

    popularMovie.results?.forEach(
      (e) {
        if (limitedPopularMovies.length >= limit) return;

        final m = PopularMovieDetail(
          id: e.id,
          title: e.title,
          description: e.overview,
          imageUrl: e.posterPath,
        );
        limitedPopularMovies.add(m);
      },
    );

    return PopularMovieDTO(
      page: popularMovie.page,
      popularMovies: limitedPopularMovies,
    );
  }
  final int? page;

  final List<PopularMovieDetail>? popularMovies;

  Map<String, dynamic> toJson() => _$PopularMovieDTOToJson(this);
}

@JsonSerializable()
final class PopularMovieDetail {
  PopularMovieDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
  factory PopularMovieDetail.fromJson(Map<String, dynamic> json) => _$PopularMovieDetailFromJson(json);
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;

  Map<String, dynamic> toJson() => _$PopularMovieDetailToJson(this);
}

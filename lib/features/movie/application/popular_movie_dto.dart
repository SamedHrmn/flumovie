import 'package:flumovie/features/movie/domain/popular_movie.dart';

class PopularMovieDTO {
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
              imageUrl: e.posterPath,
            ),
          )
          .toList(),
    );
  }
  final int? page;
  final List<_PopularMovieDetail>? popularMovies;
}

class _PopularMovieDetail {
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
}

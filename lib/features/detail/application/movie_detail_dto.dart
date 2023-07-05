import 'package:flumovie/features/detail/domain/movie_detail.dart';

class MovieDetailDTO {
  MovieDetailDTO({required this.movieDetail});

  factory MovieDetailDTO.fromDomain(MovieDetail movieDetail) => MovieDetailDTO(
        movieDetail: movieDetail,
      );

  final MovieDetail? movieDetail;
}

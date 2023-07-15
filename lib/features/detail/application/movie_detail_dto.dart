import 'package:flumovie/features/detail/domain/movie_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_dto.g.dart';

@JsonSerializable()
class MovieDetailDTO {
  MovieDetailDTO({required this.movieDetail});

  factory MovieDetailDTO.fromJson(Map<String, dynamic> json) => _$MovieDetailDTOFromJson(json);

  factory MovieDetailDTO.fromDomain(MovieDetail movieDetail) => MovieDetailDTO(
        movieDetail: movieDetail,
      );

  final MovieDetail? movieDetail;

  Map<String, dynamic> toJson() => _$MovieDetailDTOToJson(this);
}

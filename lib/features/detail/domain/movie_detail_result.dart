import 'package:flumovie/features/detail/application/movie_detail_dto.dart';

class MovieDetailResult {
  MovieDetailResult(this.details, {this.error});
  final MovieDetailDTO? details;
  final String? error;
}

import 'dart:developer';

import 'package:flumovie/core/util/flu_cubit.dart';
import 'package:flumovie/features/detail/application/cubit/movie_detail_state.dart';
import 'package:flumovie/shared/s_data/i_movie_repository.dart';

class MovieDetailCubit extends FluCubit<MovieDetailState> {
  MovieDetailCubit({required this.movieRepository}) : super(const MovieDetailState(status: MovieDetailStatus.initial));
  final IMovieRepository movieRepository;

  Future<void> getMovieDetail({required int? movieId}) async {
    try {
      emit(state.copyWith(status: MovieDetailStatus.loading));
      if (movieId == null) {
        emit(state.copyWith(status: MovieDetailStatus.failure));
        return;
      }

      if (state.movieDetailDTO != null && movieId == state.movieDetailDTO!.movieDetail!.id) {
        emit(state.copyWith(status: MovieDetailStatus.success));
        return;
      }

      final detailDTO = await movieRepository.getMovieDetail(movieId: movieId);
      if (detailDTO != null) {
        emit(state.copyWith(movieDetailDTO: detailDTO, status: MovieDetailStatus.success));
      } else {
        emit(state.copyWith(status: MovieDetailStatus.failure));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: MovieDetailStatus.failure));
    }
  }

  @override
  MovieDetailState? fromJson(Map<String, dynamic> json) {
    log('Movie detail from hydratedbloc!', name: 'MovieDetailCubit');
    return MovieDetailState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(MovieDetailState state) {
    log('Movie detail write hydratedbloc!', name: 'MovieDetailCubit');
    return state.toJson();
  }
}

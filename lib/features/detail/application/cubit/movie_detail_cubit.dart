import 'dart:developer';

import 'package:flumovie/features/detail/application/cubit/movie_detail_state.dart';
import 'package:flumovie/shared/s_data/dio_movie_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MovieDetailCubit extends HydratedCubit<MovieDetailState> {
  MovieDetailCubit({required this.dioMovieRepository}) : super(const MovieDetailState(status: MovieDetailStatus.initial));
  final DioMovieRepository dioMovieRepository;

  Future<void> getMovieDetail({required int? movieId}) async {
    try {
      emit(state.copyWith(status: MovieDetailStatus.loading));
      if (movieId == null) {
        emit(state.copyWith(status: MovieDetailStatus.failure));
        return;
      }

      if (state.movieDetailDTO != null) {
        emit(state.copyWith(status: MovieDetailStatus.success));
        return;
      }

      final detailDTO = await dioMovieRepository.getMovieDetail(movieId: movieId);
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

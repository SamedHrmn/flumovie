import 'dart:developer';

import 'package:flumovie/features/home/popular/application/cubit/popular_movie_state.dart';
import 'package:flumovie/shared/s_data/dio_movie_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PopularMovieCubit extends HydratedCubit<PopularMovieState> {
  PopularMovieCubit({
    required this.dioMovieRepository,
    this.clearCache = false,
  }) : super(const PopularMovieState(status: PopularMovieStatus.initial)) {
    getPopularMovies();
  }

  final DioMovieRepository dioMovieRepository;
  final bool clearCache;

  Future<void> getPopularMovies() async {
    if (clearCache) {
      await HydratedBloc.storage.clear();
      await HydratedBloc.storage.close();
    }

    try {
      emit(state.copyWith(status: PopularMovieStatus.loading));

      if (state.popularMovieDTO != null) {
        emit(state.copyWith(status: PopularMovieStatus.success));
        return;
      }

      final movieDTO = await dioMovieRepository.getPopularMovies();
      if (movieDTO == null) {
        emit(state.copyWith(status: PopularMovieStatus.failure));

        return;
      }

      emit(state.copyWith(status: PopularMovieStatus.success, popularMovieDTO: movieDTO));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: PopularMovieStatus.failure));
    }
  }

  @override
  PopularMovieState? fromJson(Map<String, dynamic> json) {
    if (clearCache) return null;
    log('Popular movies from hydratedbloc!', name: 'PopularMovieCubit');
    return PopularMovieState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PopularMovieState state) {
    log('Popular movies write hydratedbloc!', name: 'PopularMovieCubit');
    return state.toJson();
  }
}

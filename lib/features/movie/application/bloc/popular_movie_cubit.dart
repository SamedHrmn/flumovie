import 'dart:developer';

import 'package:flumovie/features/movie/application/bloc/popular_movie_state.dart';
import 'package:flumovie/features/movie/data/dio_movie_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PopularMovieCubit extends HydratedCubit<PopularMovieState> {
  PopularMovieCubit({
    required this.dioMovieRepository,
  }) : super(const PopularMovieState(status: PopularMovieStatus.initial)) {
    hydrate();
    getPopularMovies();
  }

  final DioMovieRepository dioMovieRepository;

  Future<void> getPopularMovies() async {
    try {
      emit(state.copyWith(status: PopularMovieStatus.loading));

      if (state.popularMovieDTO != null) {
        emit(state.copyWith(status: PopularMovieStatus.success));
        return;
      }

      final movieResult = await dioMovieRepository.getPopularMovies();
      if (movieResult.movies == null) {
        emit(state.copyWith(status: PopularMovieStatus.failure));
        log(movieResult.error.toString());
        return;
      }

      final movieDto = movieResult.movies!;
      emit(state.copyWith(status: PopularMovieStatus.success, popularMovieDTO: movieDto));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: PopularMovieStatus.failure));
    }
  }

  @override
  PopularMovieState? fromJson(Map<String, dynamic> json) {
    log('Popular movies from hydratedbloc!', name: 'PopularMovieCubit');

    return PopularMovieState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PopularMovieState state) {
    log('Popular movies write hydratedbloc!', name: 'PopularMovieCubit');
    return state.toJson();
  }
}

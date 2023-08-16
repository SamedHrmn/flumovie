import 'dart:developer';
import 'package:flumovie/core/util/flu_cubit.dart';
import 'package:flumovie/features/home/popular/application/cubit/popular_movie_state.dart';
import 'package:flumovie/shared/s_data/i_movie_repository.dart';

class PopularMovieCubit extends FluCubit<PopularMovieState> {
  PopularMovieCubit({
    required this.movieRepository,
    this.clearCache = false,
  }) : super(const PopularMovieState(status: PopularMovieStatus.initial)) {
    getPopularMovies();
  }

  final IMovieRepository movieRepository;
  final bool clearCache;

  Future<void> getPopularMovies() async {
    try {
      if (clearCache) {
        await FluCubit.clearCache();
      }

      emit(state.copyWith(status: PopularMovieStatus.loading));

      if (state.popularMovieDTO != null) {
        emit(state.copyWith(status: PopularMovieStatus.success));
        return;
      }

      final movieDTO = await movieRepository.getPopularMovies();
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

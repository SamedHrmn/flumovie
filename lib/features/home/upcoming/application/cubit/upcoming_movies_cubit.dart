import 'dart:developer';
import 'package:flumovie/core/util/flu_cubit.dart';
import 'package:flumovie/features/home/upcoming/application/cubit/upcoming_movies_state.dart';
import 'package:flumovie/shared/s_data/i_movie_repository.dart';

class UpcomingMoviesCubit extends FluCubit<UpcomingMoviesState> {
  UpcomingMoviesCubit({required this.movieRepository, this.clearCache = false}) : super(UpcomingMoviesState(status: UpcomingMoviesStatus.initial)) {
    getUpcomingMovies();
  }

  final IMovieRepository movieRepository;
  final bool clearCache;

  Future<void> getUpcomingMovies() async {
    try {
      if (clearCache) {
        await FluCubit.clearCache();
      }

      if (state.upcomingMoviesDTO != null) return;

      emit(UpcomingMoviesState(status: UpcomingMoviesStatus.loading));

      final response = await movieRepository.upcomingMovies();
      if (response == null) {
        emit(state.copyWith(status: UpcomingMoviesStatus.failure));
        return;
      }

      emit(
        state.copyWith(
          status: UpcomingMoviesStatus.success,
          upcomingMoviesDTO: response,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: UpcomingMoviesStatus.failure));
    }
  }

  @override
  UpcomingMoviesState? fromJson(Map<String, dynamic> json) {
    return UpcomingMoviesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UpcomingMoviesState state) {
    return state.toJson();
  }
}

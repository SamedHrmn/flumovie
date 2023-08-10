import 'dart:developer';

import 'package:flumovie/features/search/application/cubit/movie_search_state.dart';
import 'package:flumovie/shared/s_data/i_movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit({required this.movieRepository})
      : super(const MovieSearchState(
          status: MovieSearchStatus.initial,
        ));

  final IMovieRepository movieRepository;

  Future<void> searchMovie({required String title}) async {
    try {
      emit(const MovieSearchState(status: MovieSearchStatus.loading));
      final movieSearchDTO = await movieRepository.searchMovie(title: title);

      if (movieSearchDTO == null) {
        emit(state.copyWith(status: MovieSearchStatus.failure));
        return;
      } else if (movieSearchDTO.movieSearch?.totalResults == 0) {
        emit(state.copyWith(status: MovieSearchStatus.noResult, queryString: title));
        return;
      }

      emit(state.copyWith(movieSearchDTO: movieSearchDTO, status: MovieSearchStatus.success, queryString: title));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: MovieSearchStatus.failure));
    }
  }
}

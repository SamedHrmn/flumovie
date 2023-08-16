import 'package:easy_localization/easy_localization.dart';
import 'package:flumovie/core/components/custom/flutext.dart';
import 'package:flumovie/core/constants/localization_constant.dart';
import 'package:flumovie/features/home/popular/application/cubit/popular_movie_cubit.dart';
import 'package:flumovie/features/home/popular/application/cubit/popular_movie_state.dart';
import 'package:flumovie/features/home/popular/presentation/popular_movie_slider.dart';
import 'package:flumovie/features/home/upcoming/application/cubit/upcoming_movies_cubit.dart';
import 'package:flumovie/features/home/upcoming/application/cubit/upcoming_movies_state.dart';
import 'package:flumovie/features/home/upcoming/presentation/upcoming_movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieHomeView extends StatefulWidget {
  const MovieHomeView({super.key});

  @override
  State<MovieHomeView> createState() => _MovieHomeViewState();
}

class _MovieHomeViewState extends State<MovieHomeView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          popularMovieBuilder(),
          upcomingMovieBuilder(),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  Column upcomingMovieBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FluText(text: LocalizationConstants.home_upcomingMovies.tr(), size: 20, weight: FluTextWeight.bold),
        ),
        BlocBuilder<UpcomingMoviesCubit, UpcomingMoviesState>(
          builder: (context, state) {
            switch (state.status) {
              case UpcomingMoviesStatus.loading:
              case UpcomingMoviesStatus.initial:
                return const CircularProgressIndicator.adaptive();
              case UpcomingMoviesStatus.failure:
                return FluText(text: LocalizationConstants.error_type1.tr());
              case UpcomingMoviesStatus.success:
                final upcomingMovies = state.upcomingMoviesDTO!.upcomingMovies;

                return UpcomingMoviesList(upcomingMovies: upcomingMovies);
            }
          },
        ),
      ],
    );
  }

  BlocBuilder<PopularMovieCubit, PopularMovieState> popularMovieBuilder() {
    return BlocBuilder<PopularMovieCubit, PopularMovieState>(
      builder: (context, state) {
        switch (state.status) {
          case PopularMovieStatus.loading:
          case PopularMovieStatus.initial:
            return const CircularProgressIndicator.adaptive();
          case PopularMovieStatus.failure:
            return FluText(text: LocalizationConstants.error_type1.tr());
          case PopularMovieStatus.success:
            final popularMovies = state.popularMovieDTO!.popularMovies!;

            return PopularMovieSlider(popularMovies: popularMovies);
        }
      },
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/constants/color_constant.dart';
import 'package:flumovie/features/detail/presentation/movie_detail_view.dart';
import 'package:flumovie/features/home/popular/application/cubit/popular_movie_cubit.dart';
import 'package:flumovie/features/home/popular/application/cubit/popular_movie_state.dart';
import 'package:flumovie/features/home/popular/application/popular_movie_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';

part 'popular/popular_movie_slider_notifier.dart';

class MovieHomeView extends StatefulWidget {
  const MovieHomeView({super.key});

  @override
  State<MovieHomeView> createState() => _MovieHomeViewState();
}

class _MovieHomeViewState extends State<MovieHomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PopularMovieCubit, PopularMovieState>(
          builder: (context, state) {
            switch (state.status) {
              case PopularMovieStatus.loading:
              case PopularMovieStatus.initial:
                return const CircularProgressIndicator.adaptive();
              case PopularMovieStatus.failure:
                return const Text('An error occured');
              case PopularMovieStatus.success:
                final popularMovies = state.popularMovieDTO!.popularMovies!;

                return _PopularMovieSlider(popularMovies: popularMovies);
            }
          },
        ),
      ],
    );
  }
}

class _PopularMovieSlider extends StatefulWidget {
  const _PopularMovieSlider({required this.popularMovies});

  final List<PopularMovieDetail> popularMovies;

  @override
  State<_PopularMovieSlider> createState() => __PopularMovieSliderState();
}

class __PopularMovieSliderState extends State<_PopularMovieSlider> {
  final _PopularMovieSliderNotifier popularMovieSliderNotifier = _PopularMovieSliderNotifier();

  @override
  void initState() {
    super.initState();
    popularMovieSliderNotifier.computeImageColors(widget.popularMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          height: 425,
        ),
        Positioned.fill(
          child: ValueListenableBuilder(
            valueListenable: popularMovieSliderNotifier,
            builder: (context, __, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      popularMovieSliderNotifier.getBackgroundColorFromImage(widget.popularMovies),
                      Colors.white,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: popularMovieSliderNotifier,
            builder: (context, __, _) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 24,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: popularMovieSliderNotifier.getBackgroundColorFromImage(widget.popularMovies),
                      blurRadius: 10,
                      spreadRadius: 10,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        CarouselSlider.builder(
          itemCount: widget.popularMovies.length,
          itemBuilder: (context, index, realIndex) => _PopularMovieCard(
            popularMovieDetail: widget.popularMovies[index],
          ),
          options: CarouselOptions(
            height: 415,
            onPageChanged: (index, reason) => popularMovieSliderNotifier.updateIndex(index),
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            viewportFraction: 0.77,
            disableCenter: true,
            enlargeCenterPage: true,
          ),
        )
      ],
    );
  }
}

class _PopularMovieCard extends StatelessWidget {
  const _PopularMovieCard({
    required this.popularMovieDetail,
  });

  final PopularMovieDetail popularMovieDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => MovieDetailView(movieId: popularMovieDetail.id),
        ),
      ),
      child: SizedBox(
        child: FluNetworkImage(
          url: popularMovieDetail.imageUrl,
        ),
      ),
    );
  }
}

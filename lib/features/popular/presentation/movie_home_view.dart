import 'package:carousel_slider/carousel_slider.dart';
import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/components/custom/flumovie_scaffold.dart';
import 'package:flumovie/features/popular/application/bloc/popular_movie_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/bloc/popular_movie_cubit.dart';

class MovieHomeView extends StatefulWidget {
  const MovieHomeView({super.key});

  @override
  State<MovieHomeView> createState() => _MovieHomeViewState();
}

class _MovieHomeViewState extends State<MovieHomeView> {
  @override
  Widget build(BuildContext context) {
    return FlumovieScaffold(
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<PopularMovieCubit, PopularMovieState>(
              builder: (context, state) {
                switch (state.status) {
                  case PopularMovieStatus.loading:
                  case PopularMovieStatus.initial:
                    return const CircularProgressIndicator.adaptive();
                  case PopularMovieStatus.failure:
                    return const Text('An error occured');
                  case PopularMovieStatus.success:
                    final popularMovies = state.popularMovieDTO!.popularMovies!;

                    return CarouselSlider.builder(
                      itemCount: popularMovies.length,
                      itemBuilder: (context, index, realIndex) => SizedBox(
                        width: 120,
                        child: Column(
                          children: [
                            FluNetworkImage(
                              url: popularMovies[index].imageUrl,
                            ),
                            Text(
                              popularMovies[index].title ?? '-',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        viewportFraction: 0.6,
                        disableCenter: true,
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

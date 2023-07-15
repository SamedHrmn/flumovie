import 'package:carousel_slider/carousel_slider.dart';
import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/components/custom/flumovie_scaffold.dart';
import 'package:flumovie/features/detail/presentation/movie_detail_view.dart';

import 'package:flumovie/features/popular/application/popular_movie_dto.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/cubit/popular_movie_cubit.dart';
import '../application/cubit/popular_movie_state.dart';

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
                      itemBuilder: (context, index, realIndex) => _PopularMovieCard(
                        popularMovieDetail: popularMovies[index],
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
        width: 120,
        child: Column(
          children: [
            FluNetworkImage(
              url: popularMovieDetail.imageUrl,
            ),
            Text(
              popularMovieDetail.title ?? '-',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

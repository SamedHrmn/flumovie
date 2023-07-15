import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/components/custom/flumovie_scaffold.dart';
import 'package:flumovie/features/detail/application/cubit/movie_detail_cubit.dart';
import 'package:flumovie/features/detail/application/cubit/movie_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({required this.movieId, super.key});

  final int? movieId;

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MovieDetailCubit>().getMovieDetail(movieId: widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlumovieScaffold(
      child: Stack(
        children: [
          BlocBuilder<MovieDetailCubit, MovieDetailState>(
            builder: (context, state) {
              switch (state.status) {
                case MovieDetailStatus.initial:
                  return const SizedBox();
                case MovieDetailStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case MovieDetailStatus.failure:
                  return const Center(
                    child: Text('An error occured'),
                  );
                case MovieDetailStatus.success:
                  final model = state.movieDetailDTO!;

                  return Column(
                    children: [
                      FluNetworkImage(
                        url: model.movieDetail?.posterPath,
                      ),
                    ],
                  );
              }
            },
          ),
          Positioned(
            top: 0,
            left: 24,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          )
        ],
      ),
    );
  }
}

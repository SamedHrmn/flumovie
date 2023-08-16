import 'package:easy_localization/easy_localization.dart';
import 'package:flumovie/core/components/custom/flu_circular_icon_button.dart';
import 'package:flumovie/core/components/custom/flu_icon_button.dart';
import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/components/custom/flu_primary_button.dart';
import 'package:flumovie/core/components/custom/flumovie_scaffold.dart';
import 'package:flumovie/core/components/custom/flutext.dart';
import 'package:flumovie/core/constants/color_constant.dart';
import 'package:flumovie/core/constants/localization_constant.dart';
import 'package:flumovie/core/util/datetime_ext.dart';
import 'package:flumovie/core/util/navigation/navigation_manager.dart';
import 'package:flumovie/features/detail/application/cubit/add_favorite_cubit.dart';
import 'package:flumovie/features/detail/application/cubit/favorites_state.dart';
import 'package:flumovie/features/detail/application/cubit/movie_detail_cubit.dart';
import 'package:flumovie/features/detail/application/cubit/movie_detail_state.dart';
import 'package:flumovie/features/detail/application/movie_detail_dto.dart';
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
      child: SingleChildScrollView(
        child: Stack(
          children: [
            pageBody(),
            Positioned(
              top: 32,
              left: 16,
              child: backButton(),
            ),
          ],
        ),
      ),
    );
  }

  FluCircularIconButton backButton() {
    return FluCircularIconButton(
      onPressed: () => NavigationManager.instance.pop(context),
      icon: FluIcon.back,
      backgroundColor: ColorConstant.primaryButtonColor,
      iconColor: Colors.white,
    );
  }

  BlocBuilder<MovieDetailCubit, MovieDetailState> pageBody() {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        switch (state.status) {
          case MovieDetailStatus.initial:
            return const SizedBox();
          case MovieDetailStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case MovieDetailStatus.failure:
            return Center(
              child: FluText(
                text: LocalizationConstants.error_type1.tr(),
              ),
            );
          case MovieDetailStatus.success:
            final model = state.movieDetailDTO!;

            return _DetailBody(model: model);
        }
      },
    );
  }
}

//*-----------------------------------------------------------------------------

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.model});

  final MovieDetailDTO model;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: screenH * 0.72,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: posterImage(model, screenH),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: posterGradient(),
              ),
              Positioned(
                bottom: -16,
                child: favoriteBuilder(model),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        otherDetails(model, context),
      ],
    );
  }

  Padding otherDetails(MovieDetailDTO model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: FluText(
                  text: model.movieDetail?.title ?? '-',
                  weight: FluTextWeight.bold,
                  size: 18,
                ),
              ),
              FluText(
                text: model.movieDetail!.releaseDate.parseDateTime(context),
                size: 12,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FluText(
                  text: LocalizationConstants.detail_overview.tr(),
                  size: 16,
                  weight: FluTextWeight.bold,
                ),
                const SizedBox(height: 8),
                FluText(
                  text: model.movieDetail?.overview ?? '-',
                ),
              ],
            ),
          ),
          FluText(
            text: model.movieDetail?.voteAverage?.toString() ?? '-',
          ),
          FluText(
            text: model.movieDetail?.budget?.toString() ?? '-',
          ),
          if (model.movieDetail?.genres != null) ...{
            Row(
              children: model.movieDetail!.genres!.map((e) => FluText(text: e.name ?? '-')).toList(),
            ),
          },
        ],
      ),
    );
  }

  BlocBuilder<AddFavoriteCubit, FavoritesState> favoriteBuilder(MovieDetailDTO model) {
    return BlocBuilder<AddFavoriteCubit, FavoritesState>(
      builder: (context, state) {
        final isMovieAlreadyFavorited = state.favorites.contains(model.movieDetail);

        return FluPrimaryButton(
          backgroundColor: ColorConstant.primaryButtonColor,
          onPressed: () => context.read<AddFavoriteCubit>().addFavorite(movieDetail: model.movieDetail!),
          child: Row(
            children: [
              Icon(
                isMovieAlreadyFavorited ? Icons.remove : Icons.add,
                size: 16,
                color: ColorConstant.textWhite,
              ),
              FluText(
                text: isMovieAlreadyFavorited ? LocalizationConstants.favorite_removeFavorite.tr() : LocalizationConstants.favorite_addFavorite.tr(),
                size: 12,
                color: ColorConstant.textWhite,
                weight: FluTextWeight.bold,
              ),
            ],
          ),
        );
      },
    );
  }

  Container posterGradient() {
    return Container(
      height: 120,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0, 0.4],
          colors: [
            Colors.white,
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget posterImage(MovieDetailDTO model, double screenH) {
    return FluNetworkImage(
      url: model.movieDetail?.posterPath,
      height: screenH * 0.72,
      alignment: () => const Alignment(0, -0.8),
      fit: BoxFit.cover,
    );
  }
}

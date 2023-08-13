import 'package:carousel_slider/carousel_slider.dart';
import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/constants/color_constant.dart';
import 'package:flumovie/core/util/navigation/navigation_manager.dart';
import 'package:flumovie/features/home/popular/application/popular_movie_dto.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

part '../popular_movie_slider_notifier.dart';

class PopularMovieSlider extends StatefulWidget {
  const PopularMovieSlider({required this.popularMovies, super.key});

  final List<PopularMovieDetail> popularMovies;

  @override
  State<PopularMovieSlider> createState() => _PopularMovieSliderState();
}

class _PopularMovieSliderState extends State<PopularMovieSlider> {
  final _PopularMovieSliderNotifier popularMovieSliderNotifier = _PopularMovieSliderNotifier();

  @override
  void initState() {
    super.initState();
    popularMovieSliderNotifier.computeImageColors(widget.popularMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Stack(
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
      onTap: () => NavigationManager.instance.go(
        des: FluNavigations.movieDetailView,
        param: popularMovieDetail.id,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: FluNetworkImage.withImageProvider(
              url: popularMovieDetail.imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

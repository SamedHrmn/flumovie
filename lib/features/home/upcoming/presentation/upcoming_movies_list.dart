import 'package:easy_localization/easy_localization.dart';
import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/components/custom/flutext.dart';
import 'package:flumovie/core/constants/localization_constant.dart';
import 'package:flumovie/core/util/datetime_ext.dart';
import 'package:flumovie/core/util/navigation/navigation_manager.dart';
import 'package:flumovie/features/home/upcoming/application/upcoming_movies_dto.dart';
import 'package:flutter/material.dart';

class UpcomingMoviesList extends StatelessWidget {
  const UpcomingMoviesList({required this.upcomingMovies, super.key});

  final List<UpcomingMoviesDetail> upcomingMovies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final model = upcomingMovies[index];

          return GestureDetector(
            onTap: () => NavigationManager.instance.go(des: FluNavigations.movieDetailView, param: model.id),
            child: SizedBox(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 16,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: FluNetworkImage(
                        url: model.backdropPath,
                        fit: BoxFit.cover,
                        height: double.maxFinite,
                        radius: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FluText(
                    text: model.releaseDate?.parseDateTime(context) ?? LocalizationConstants.upcoming_unknownReleaseDate.tr(),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: upcomingMovies.length,
      ),
    );
  }
}

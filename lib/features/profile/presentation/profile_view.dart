import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/components/custom/flutext.dart';
import 'package:flumovie/core/gen/assets.gen.dart';
import 'package:flumovie/core/util/navigation/navigation_manager.dart';
import 'package:flumovie/features/detail/application/cubit/add_favorite_cubit.dart';
import 'package:flumovie/features/detail/application/cubit/favorites_state.dart';
import 'package:flumovie/features/profile/application/profile_cubit.dart';
import 'package:flumovie/features/profile/application/profile_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ProfileCubit, ProfileDTO>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Row(
                children: [
                  Image.asset(
                    state.avatarPath ?? Assets.icons.avatar1.path,
                    width: 100,
                  ),
                  const SizedBox(width: 16),
                  FluText(text: state.nickName, size: 18),
                ],
              ),
            );
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: FluText(
                text: 'Your Favorites',
                size: 16,
                weight: FluTextWeight.bold,
              ),
            ),
            ...[
              BlocBuilder<AddFavoriteCubit, FavoritesState>(
                builder: (context, state) {
                  if (state.favorites.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: FluText(
                        text: 'You dont have any favovirte movie yet',
                        size: 12,
                      ),
                    );
                  }

                  final movies = state.favorites;

                  return SizedBox(
                    height: 162,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => NavigationManager.instance.go(
                          des: FluNavigations.movieDetailView,
                          param: movies[index].id,
                        ),
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              FluNetworkImage(
                                url: movies[index].posterPath,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ],
    );
  }
}

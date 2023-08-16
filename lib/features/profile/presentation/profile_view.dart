import 'package:easy_localization/easy_localization.dart';
import 'package:flumovie/core/components/custom/flu_icon_button.dart';
import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/components/custom/flutext.dart';
import 'package:flumovie/core/constants/localization_constant.dart';
import 'package:flumovie/core/gen/assets.gen.dart';
import 'package:flumovie/core/util/localization_manager.dart';
import 'package:flumovie/core/util/navigation/navigation_manager.dart';
import 'package:flumovie/features/detail/application/cubit/add_favorite_cubit.dart';
import 'package:flumovie/features/detail/application/cubit/favorites_state.dart';
import 'package:flumovie/features/detail/domain/movie_detail.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  void showMenuWithDynamicPosition(BuildContext context, {required Map<String, List<String>> menuItems}) {
    final button = context.findRenderObject() as RenderBox?;
    if (button == null) return;

    final offset = button.localToGlobal(Offset(0, button.size.height));
    final position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy,
      offset.dx + button.size.width,
      offset.dy,
    );

    final menuEntries = menuItems.entries.map((entry) {
      final submenuItems = entry.value.map((subItem) {
        return PopupMenuItem<String>(
          value: subItem,
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: context.locale.languageCode == subItem ? Colors.green : Colors.transparent,
                size: 12,
              ),
              MenuItemButton(
                onPressed: () async {
                  await LocalizationManager.instance.changeLanguage(context, Locale.fromSubtags(languageCode: subItem));
                  if (!mounted) return;
                  await NavigationManager.instance.goClearBackAll(context, des: FluNavigations.bottomBarView);
                },
                child: FluText(text: subItem),
              ),
            ],
          ),
        );
      }).toList();

      return PopupMenuItem<String>(
        value: entry.key,
        padding: EdgeInsets.zero,
        child: SubmenuButton(
          menuChildren: submenuItems,
          alignmentOffset: Offset(-button.size.width, 24),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: FluText(text: entry.key),
        ),
      );
    }).toList();

    showMenu<void>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      items: menuEntries,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileInformationBuilder(),
              Builder(
                builder: (context) {
                  return FluIconButton(
                    icon: FluIcon.home,
                    onPressed: () {
                      showMenuWithDynamicPosition(
                        context,
                        menuItems: {
                          LocalizationConstants.profile_languageSettings.tr(): context.supportedLocales
                              .map(
                                (e) => e.toLanguageTag(),
                              )
                              .toList(),
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          favorites(),
        ],
      ),
    );
  }

  Column favorites() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        yourFavoritesText(),
        ...[
          favoritesBuilder(),
        ],
      ],
    );
  }

  BlocBuilder<AddFavoriteCubit, FavoritesState> favoritesBuilder() {
    return BlocBuilder<AddFavoriteCubit, FavoritesState>(
      builder: (context, state) {
        if (state.favorites.isEmpty) {
          return favoritesEmptyText();
        }

        final movies = state.favorites;

        return SizedBox(
          height: 162,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) => _FavoriteMovieCard(
              movieDetail: movies[index],
            ),
          ),
        );
      },
    );
  }

  Padding favoritesEmptyText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FluText(
        text: LocalizationConstants.favorite_noFavoriteYet.tr(),
        size: 12,
      ),
    );
  }

  Padding yourFavoritesText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FluText(
        text: LocalizationConstants.profile_yourFavorites.tr(),
        size: 16,
        weight: FluTextWeight.bold,
      ),
    );
  }

  BlocBuilder<ProfileCubit, ProfileDTO> profileInformationBuilder() {
    return BlocBuilder<ProfileCubit, ProfileDTO>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          child: Row(
            children: [
              Image.asset(
                state.avatarPath ?? Assets.icons.avatar1.path,
                width: 100,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FluText(text: state.nickName, size: 18),
                  BlocBuilder<AddFavoriteCubit, FavoritesState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4),
                          FluText(
                            text: state.favorites.length.toString(),
                            size: 14,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FavoriteMovieCard extends StatelessWidget {
  const _FavoriteMovieCard({required this.movieDetail});

  final MovieDetail movieDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationManager.instance.go(
        des: FluNavigations.movieDetailView,
        param: movieDetail.id,
      ),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 16,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            FluNetworkImage(
              url: movieDetail.posterPath,
              radius: 12,
            ),
          ],
        ),
      ),
    );
  }
}

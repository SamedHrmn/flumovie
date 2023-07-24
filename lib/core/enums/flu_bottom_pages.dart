import 'package:flumovie/core/components/custom/flu_icon_button.dart';
import 'package:flumovie/features/home/movie_home_view.dart';
import 'package:flumovie/features/profile/presentation/profile_view.dart';
import 'package:flumovie/features/search/presentation/search_movie_view.dart';
import 'package:flutter/material.dart';

enum FluBottomPages {
  home,
  search,
  profile;

  const FluBottomPages();

  Widget toPage() {
    switch (this) {
      case FluBottomPages.home:
        return const MovieHomeView();
      case FluBottomPages.search:
        return const SearchMovieView();
      case FluBottomPages.profile:
        return const ProfileView();
    }
  }

  FluIcon toFluIcon() {
    switch (this) {
      case FluBottomPages.home:
        return FluIcon.home;
      case FluBottomPages.search:
        return FluIcon.search;
      case FluBottomPages.profile:
        return FluIcon.profile;
    }
  }
}

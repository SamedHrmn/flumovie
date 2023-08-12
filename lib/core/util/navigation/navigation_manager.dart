// ignore_for_file: prefer_constructors_over_static_methods

import 'package:flumovie/features/detail/presentation/movie_detail_view.dart';
import 'package:flumovie/features/entry/flu_bottombar_view.dart';
import 'package:flumovie/features/entry/onboard/onboard_view.dart';
import 'package:flutter/material.dart';

enum FluNavigations {
  onboardView,
  bottomBarView,
  movieDetailView;

  const FluNavigations();

  Widget toPage([Object? param]) {
    switch (this) {
      case FluNavigations.onboardView:
        return const OnboardView();
      case FluNavigations.bottomBarView:
        return const FluBottomBarView();
      case FluNavigations.movieDetailView:
        assert(param! is int?, 'Navigation param error in $param');
        return MovieDetailView(movieId: param as int?);
    }
  }
}

class NavigationManager {
  const NavigationManager._();
  static NavigationManager get instance => _instance ??= const NavigationManager._();
  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigationManager? _instance;

  Future<void> go({required FluNavigations des, Object? param}) => navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => des.toPage(param),
        ),
      );

  Future<void> goClearBackAll(BuildContext context, {required FluNavigations des}) => navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => des.toPage(),
        ),
        (route) => false,
      );

  void pop(BuildContext context) => navigatorKey.currentState!.pop();
}

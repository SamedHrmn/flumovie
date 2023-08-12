import 'dart:developer';
import 'package:flutter/material.dart';

class FluNavigationObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(route.settings.name ?? 'nullRoute');
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(route.settings.name ?? 'nullRoute');
    super.didPush(route, previousRoute);
  }
}

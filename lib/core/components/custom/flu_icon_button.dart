import 'package:flumovie/core/components/base/base_icon_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum FluIcon {
  back(18),
  home(24),
  search(24),
  profile(24);

  final double size;

  const FluIcon(this.size);

  Widget toWidget({Color? color}) {
    switch (this) {
      case FluIcon.back:
        return _icon(Icons.arrow_back_ios_new_outlined, color);
      case FluIcon.home:
        return _icon(Icons.home_outlined, color);
      case FluIcon.search:
        return _icon(Icons.search_outlined, color);
      case FluIcon.profile:
        return _icon(Icons.person_2_outlined, color);
    }
  }

  Widget _icon(IconData iconData, Color? color) => Icon(
        iconData,
        color: color,
      );
}

class FluIconButton extends StatelessWidget {
  const FluIconButton({required this.icon, this.onPressed, this.onPressedAsync, super.key});

  final FluIcon icon;
  final VoidCallback? onPressed;
  final AsyncCallback? onPressedAsync;

  @override
  Widget build(BuildContext context) {
    return BaseIconButton(
      icon: icon.toWidget(),
      iconSize: icon.size,
      onPressed: onPressed ?? () async => await onPressedAsync?.call(),
    );
  }
}

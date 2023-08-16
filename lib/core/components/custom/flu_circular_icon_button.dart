import 'package:flumovie/core/components/base/base_icon_button.dart';
import 'package:flumovie/core/components/custom/flu_icon_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FluCircularIconButton extends StatelessWidget {
  const FluCircularIconButton({required this.icon, super.key, this.onPressed, this.onPressedAsync, this.backgroundColor, this.iconColor});

  final FluIcon icon;
  final VoidCallback? onPressed;
  final AsyncCallback? onPressedAsync;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: BaseIconButton(
        icon: icon.toWidget(color: iconColor),
        iconSize: icon.size,
        onPressed: onPressed ?? () async => await onPressedAsync?.call(),
      ),
    );
  }
}

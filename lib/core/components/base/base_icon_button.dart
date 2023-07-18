import 'package:flutter/material.dart';

class BaseIconButton extends StatelessWidget {
  const BaseIconButton({
    required this.icon,
    required this.iconSize,
    this.onPressed,
    super.key,
  });

  final Widget icon;
  final double iconSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      iconSize: iconSize,
      icon: icon,
    );
  }
}

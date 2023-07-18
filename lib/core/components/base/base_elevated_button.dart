import 'package:flutter/material.dart';

class BaseElevatedButton extends StatelessWidget {
  const BaseElevatedButton({super.key, required this.child, this.onPressed, this.backgroundColor});

  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}

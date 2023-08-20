import 'package:flutter/material.dart';

class BaseElevatedButton extends StatelessWidget {
  const BaseElevatedButton({required this.child, super.key, this.onPressed, this.backgroundColor, this.radius = 12});

  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: child,
    );
  }
}

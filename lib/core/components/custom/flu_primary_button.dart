import 'package:flumovie/core/components/base/base_elevated_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FluPrimaryButton extends StatelessWidget {
  const FluPrimaryButton({
    required this.child,
    this.onPressed,
    this.onPressedAsync,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final AsyncCallback? onPressedAsync;

  @override
  Widget build(BuildContext context) {
    return BaseElevatedButton(
      onPressed: onPressed ?? () async => await onPressedAsync?.call(),
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}

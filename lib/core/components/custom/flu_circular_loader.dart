import 'package:flutter/material.dart';

class FluCircularLoader extends StatelessWidget {
  const FluCircularLoader({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: const Center(
        child: RepaintBoundary(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}

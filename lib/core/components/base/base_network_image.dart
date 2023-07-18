import 'package:flutter/material.dart';

class BaseNetworkImage extends StatelessWidget {
  const BaseNetworkImage({super.key, this.url, this.onError, this.height, this.fit, this.alignment});

  final String? url;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry Function()? alignment;
  final Widget Function()? onError;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url ?? '-',
      height: height,
      fit: fit,
      alignment: alignment?.call() ?? Alignment.center,
      errorBuilder: (context, error, stackTrace) => onError?.call() ?? const SizedBox(),
    );
  }
}

import 'package:flumovie/core/components/base/base_network_image.dart';
import 'package:flutter/material.dart';

class FluNetworkImage extends StatelessWidget {
  const FluNetworkImage({super.key, this.url, this.height, this.fit, this.alignment, this.radius = 0});

  final String? url;
  final double? height;
  final BoxFit? fit;
  final double radius;
  final AlignmentGeometry Function()? alignment;

  @override
  Widget build(BuildContext context) {
    const baseUrl = 'https://image.tmdb.org/t/p';

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BaseNetworkImage(
        url: '$baseUrl/original/$url',
        height: height,
        fit: fit,
        alignment: alignment,
        onError: () => const Placeholder(),
      ),
    );
  }
}

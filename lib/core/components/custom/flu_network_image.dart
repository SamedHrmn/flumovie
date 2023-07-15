import 'package:flumovie/core/components/base/base_network_image.dart';
import 'package:flutter/material.dart';

class FluNetworkImage extends StatelessWidget {
  const FluNetworkImage({super.key, this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    const baseUrl = 'https://image.tmdb.org/t/p';

    return BaseNetworkImage(
      url: '$baseUrl/original/$url',
      onError: () => const Placeholder(),
    );
  }
}

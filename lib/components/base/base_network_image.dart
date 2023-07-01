import 'package:flutter/material.dart';

class BaseNetworkImage extends StatelessWidget {
  const BaseNetworkImage({super.key, this.url, this.onError});

  final String? url;
  final Widget Function()? onError;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url ?? '-',
      errorBuilder: (context, error, stackTrace) => onError?.call() ?? const SizedBox(),
    );
  }
}

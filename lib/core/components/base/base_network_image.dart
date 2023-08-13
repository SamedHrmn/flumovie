import 'package:flutter/material.dart';

class BaseNetworkImage extends StatefulWidget {
  const BaseNetworkImage({
    super.key,
    this.url,
    this.onError,
    this.height,
    this.fit,
    this.alignment,
  });

  final String? url;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry Function()? alignment;
  final Widget Function()? onError;

  static ImageProvider withImageProvider({
    String? url,
    double? height,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    Widget Function()? onError,
  }) {
    return Image.network(
      url ?? '-',
      height: height,
      fit: fit,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) => onError?.call() ?? const SizedBox(),
    ).image;
  }

  @override
  _BaseNetworkImageState createState() => _BaseNetworkImageState();
}

class _BaseNetworkImageState extends State<BaseNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: widget.url != null
          ? Image.network(
              widget.url!,
              key: ValueKey<String>(widget.url!),
              height: widget.height,
              fit: widget.fit,
              alignment: widget.alignment?.call() ?? Alignment.center,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                } else {
                  return AnimatedOpacity(
                    opacity: frame != null ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: child,
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) => widget.onError?.call() ?? const SizedBox(),
            )
          : Container(),
    );
  }
}

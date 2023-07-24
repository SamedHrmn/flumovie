import 'package:flutter/material.dart';

class FluCircleAvatar extends StatelessWidget {
  const FluCircleAvatar({super.key, this.url = '', this.isAsset = true, this.radius = 24});

  final String url;
  final bool isAsset;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: isAsset ? Image.asset(url).image : Image.network(url).image,
    );
  }
}

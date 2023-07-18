import 'package:flumovie/core/components/base/base_text.dart';
import 'package:flumovie/core/constants/color_constant.dart';
import 'package:flumovie/core/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

enum FluTextWeight {
  light,
  regular,
  bold,
  black;

  const FluTextWeight();

  FontWeight get toWeight => switch (this) {
        FluTextWeight.light => FontWeight.w300,
        FluTextWeight.regular => FontWeight.w400,
        FluTextWeight.bold => FontWeight.w700,
        FluTextWeight.black => FontWeight.w900
      };
}

class FluText extends StatelessWidget {
  const FluText({
    required this.text,
    this.weight = FluTextWeight.regular,
    this.color = ColorConstant.textBlack,
    this.size,
    super.key,
  });

  final String? text;
  final FluTextWeight weight;
  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text ?? '-',
      fontFamily: FontFamily.roboto,
      fontWeight: weight.toWeight,
      color: color,
      size: size,
    );
  }
}

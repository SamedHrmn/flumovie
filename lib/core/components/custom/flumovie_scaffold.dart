import 'package:flumovie/core/components/base/base_scaffold.dart';
import 'package:flumovie/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class FlumovieScaffold extends StatelessWidget {
  const FlumovieScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: ColorConstant.scaffoldBackgroundColor,
      body: SafeArea(top: false, child: child),
    );
  }
}

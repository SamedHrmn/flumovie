import 'package:flumovie/core/components/base/base_scaffold.dart';
import 'package:flumovie/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class FlumovieScaffold extends StatelessWidget {
  const FlumovieScaffold({required this.child, this.onWillPop, super.key});

  final Widget child;
  final Future<bool> Function()? onWillPop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WillPopScope(
        onWillPop: onWillPop ?? () async => true,
        child: BaseScaffold(
          backgroundColor: ColorConstant.scaffoldBackgroundColor,
          body: SafeArea(top: false, child: child),
        ),
      ),
    );
  }
}

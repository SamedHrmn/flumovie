import 'package:flumovie/core/components/custom/flu_icon_button.dart';
import 'package:flumovie/core/components/custom/flumovie_scaffold.dart';
import 'package:flumovie/core/constants/color_constant.dart';
import 'package:flumovie/core/enums/flu_bottom_pages.dart';
import 'package:flutter/material.dart';

part 'flu_bottombar_view_controller.dart';

class FluBottomBarView extends StatelessWidget {
  const FluBottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return FluBottomBarViewController(
      child: Builder(
        builder: (context) {
          return FlumovieScaffold(
            child: Stack(
              children: [
                const Positioned.fill(child: _PageView()),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.textBlack.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        _FluBottomBarButton(page: FluBottomPages.home),
                        _FluBottomBarButton(page: FluBottomPages.search),
                        _FluBottomBarButton(page: FluBottomPages.profile),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FluBottomBarButton extends StatelessWidget {
  const _FluBottomBarButton({required this.page, super.key});

  final FluBottomPages page;

  @override
  Widget build(BuildContext context) {
    final pageIndex = FluBottomBarViewController.of(context).pageIndex;

    return Column(
      children: [
        FluIconButton(
          icon: FluIcon.profile,
          onPressed: () => FluBottomBarViewController.of(context).jumpPage(page),
        ),
        SizedBox(
          height: 1,
          child: ColoredBox(
            color: pageIndex == page.index ? ColorConstant.primaryButtonColor : Colors.transparent,
          ),
        )
      ],
    );
  }
}

class _PageView extends StatefulWidget {
  const _PageView();

  @override
  State<_PageView> createState() => __PageViewState();
}

class __PageViewState extends State<_PageView> {
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FluBottomBarViewController.of(context).controller = controller;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: (value) {
        FluBottomBarViewController.of(context).pageIndex = value;
      },
      itemBuilder: (context, index) {
        return FluBottomPages.values[index].toPage();
      },
    );
  }
}

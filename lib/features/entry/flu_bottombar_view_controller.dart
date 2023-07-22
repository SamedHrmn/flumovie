part of 'flu_bottombar_view.dart';

// ignore: must_be_immutable
final class FluBottomBarViewController extends InheritedWidget {
  FluBottomBarViewController({required super.child, super.key});

  int pageIndex = 0;
  PageController? controller;

  static FluBottomBarViewController of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<FluBottomBarViewController>();
    assert(result != null, 'No FluBottomBarViewController found in context');
    return result!;
  }

  void jumpPage(FluBottomPages destination) => controller?.jumpToPage(destination.index);

  @override
  bool updateShouldNotify(covariant FluBottomBarViewController oldWidget) => pageIndex != oldWidget.pageIndex || controller != oldWidget.controller;
}

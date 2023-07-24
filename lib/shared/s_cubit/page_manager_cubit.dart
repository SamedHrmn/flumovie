import 'package:flumovie/core/enums/flu_bottom_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class PageManagerData {
  const PageManagerData({this.fluBottomPageController, this.fluBottomPageIndex = 0});

  final int fluBottomPageIndex;
  final PageController? fluBottomPageController;

  PageManagerData copyWith({
    PageController? fluBottomPageController,
    int? fluBottomPageIndex,
  }) {
    return PageManagerData(
      fluBottomPageController: fluBottomPageController ?? this.fluBottomPageController,
      fluBottomPageIndex: fluBottomPageIndex ?? this.fluBottomPageIndex,
    );
  }
}

class PageManagerCubit extends Cubit<PageManagerData> {
  PageManagerCubit() : super(const PageManagerData());

  void updatePageIndex(int i) {
    emit(state.copyWith(fluBottomPageIndex: i));
  }

  void setController(PageController controller) {
    emit(state.copyWith(fluBottomPageController: controller));
  }

  void jumpPage(FluBottomPages page) => state.fluBottomPageController?.jumpToPage(page.index);
}

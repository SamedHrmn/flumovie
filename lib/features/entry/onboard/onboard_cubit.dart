import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboard_dto.dart';

class OnBoardCubit extends Cubit<OnboardDTO> {
  OnBoardCubit({required this.viewData}) : super(viewData);

  final OnboardDTO viewData;

  void updateNickName(String v) {
    emit(state.copyWith(nickName: v));
  }

  void updateCurrentPage(bool v) {
    emit(state.copyWith(isSecondPageActive: v));
  }

  void updateAvatarPath(int i) {
    emit(state.copyWith(avatarPath: state.avatarAssets.elementAt(i)));
  }
}

import 'package:flumovie/features/entry/onboard/onboard_dto.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class OnBoardCubit extends HydratedCubit<OnboardDTO> {
  OnBoardCubit({required OnboardDTO viewData}) : super(viewData);

  void updateNickName(String v) {
    emit(state.copyWith(nickName: v));
  }

  void updateAvatarPath(int i) {
    emit(state.copyWith(avatarPath: state.avatarAssets.elementAt(i)));
  }

  @override
  OnboardDTO? fromJson(Map<String, dynamic> json) {
    return OnboardDTO.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(OnboardDTO state) {
    return state.toJson();
  }
}

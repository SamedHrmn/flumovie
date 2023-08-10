import 'package:flumovie/features/entry/onboard/onboard_dto.dart';
import 'package:flumovie/features/profile/application/profile_dto.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileDTO> {
  ProfileCubit({required ProfileDTO profileDTO}) : super(profileDTO);

  void saveOnboardData({required OnboardDTO onboardDTO}) {
    emit(state.copyWith(nickName: onboardDTO.nickName, avatarPath: onboardDTO.avatarPath));
  }
}

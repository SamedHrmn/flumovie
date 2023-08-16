// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flumovie/core/components/custom/flu_circle_avatar.dart';
import 'package:flumovie/core/components/custom/flu_primary_button.dart';
import 'package:flumovie/core/components/custom/flumovie_scaffold.dart';
import 'package:flumovie/core/components/custom/flutext.dart';
import 'package:flumovie/core/constants/color_constant.dart';
import 'package:flumovie/core/constants/localization_constant.dart';
import 'package:flumovie/core/util/navigation/navigation_manager.dart';
import 'package:flumovie/features/entry/onboard/onboard_cubit.dart';
import 'package:flumovie/features/entry/onboard/onboard_dto.dart';
import 'package:flumovie/features/profile/application/profile_cubit.dart';
import 'package:flumovie/shared/s_cubit/page_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widget/nick_name_page.dart';
part 'widget/profile_avatar_page.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  @override
  Widget build(BuildContext context) {
    final viewData = context.watch<PageManagerCubit>().state;

    return FlumovieScaffold(
      onWillPop: () async {
        if (viewData.onboardIsSecondPageActive) {
          return true;
        }
        return false;
      },
      child: viewData.onboardIsSecondPageActive ? const _ProfileAvatarPage() : const _NickNamePage(),
    );
  }
}

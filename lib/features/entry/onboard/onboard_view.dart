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
        if (viewData.onboardIsSecondPageActive) {}
        return false;
      },
      child: viewData.onboardIsSecondPageActive ? const _ProfileAvatarPage() : const _NickNamePage(),
    );
  }
}

class _NickNamePage extends StatelessWidget {
  const _NickNamePage();

  @override
  Widget build(BuildContext context) {
    final onboardCubit = context.read<OnBoardCubit>();

    return Column(
      children: [
        const Spacer(),
        FluText(
          text: LocalizationConstants.onboard_howCanWeCallYou.tr(),
          size: 16,
          weight: FluTextWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: TextField(
            onChanged: onboardCubit.updateNickName,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        BlocBuilder<OnBoardCubit, OnboardDTO>(
          builder: (context, state) => FluPrimaryButton(
            backgroundColor: state.nickName.isEmpty ? null : ColorConstant.primaryButtonColor,
            onPressed: state.nickName.isEmpty
                ? null
                : () {
                    context.read<PageManagerCubit>().updateOnboardSecondPage(true);
                  },
            child: FluText(
              text: LocalizationConstants.onboard_continue.tr(),
              color: state.nickName.isEmpty ? ColorConstant.textBlack : ColorConstant.textWhite,
            ),
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

class _ProfileAvatarPage extends StatefulWidget {
  const _ProfileAvatarPage();

  @override
  State<_ProfileAvatarPage> createState() => _ProfileAvatarPageState();
}

class _ProfileAvatarPageState extends State<_ProfileAvatarPage> {
  @override
  Widget build(BuildContext context) {
    final viewData = context.watch<OnBoardCubit>().state;

    return Column(
      children: [
        const Spacer(),
        const FluText(
          text: 'Choose your avatar',
          size: 16,
          weight: FluTextWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: viewData.avatarAssets
                .map(
                  (e) => _ProfileAvatarSelection(
                    itemIndex: viewData.avatarAssets.indexOf(e),
                    avatarPath: e,
                    selectedItemIndex: viewData.avatarAssets.indexOf(viewData.avatarPath),
                    onItemSelected: context.read<OnBoardCubit>().updateAvatarPath,
                  ),
                )
                .toList(),
          ),
        ),
        FluPrimaryButton(
          backgroundColor: viewData.avatarPath.isEmpty ? null : ColorConstant.primaryButtonColor,
          onPressed: viewData.avatarPath.isEmpty
              ? null
              : () {
                  context.read<ProfileCubit>().saveOnboardData(onboardDTO: viewData);
                  NavigationManager.instance.goClearBackAll(context, des: FluNavigations.bottomBarView);
                },
          child: FluText(
            text: 'Continue',
            color: viewData.avatarPath.isEmpty ? ColorConstant.textBlack : ColorConstant.textWhite,
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

class _ProfileAvatarSelection extends StatefulWidget {
  const _ProfileAvatarSelection({required this.itemIndex, required this.selectedItemIndex, required this.onItemSelected, required this.avatarPath});

  final int itemIndex;
  final int selectedItemIndex;
  final ValueChanged<int> onItemSelected;
  final String avatarPath;

  @override
  State<_ProfileAvatarSelection> createState() => _ProfileAvatarSelectionState();
}

class _ProfileAvatarSelectionState extends State<_ProfileAvatarSelection> {
  @override
  Widget build(BuildContext context) {
    final isSelected = widget.itemIndex == widget.selectedItemIndex;

    return GestureDetector(
      onTap: () {
        widget.onItemSelected(widget.itemIndex);
      },
      child: Stack(
        children: [
          Positioned(
            right: 24,
            top: 24,
            child: FluCircleAvatar(
              radius: 64,
              url: widget.avatarPath,
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Container(
              width: 24,
              height: 24,
              color: isSelected ? ColorConstant.textBlack : ColorConstant.textWhite,
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: ColorConstant.textWhite,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

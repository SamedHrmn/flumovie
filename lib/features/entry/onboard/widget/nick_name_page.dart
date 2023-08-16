part of '../onboard_view.dart';

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

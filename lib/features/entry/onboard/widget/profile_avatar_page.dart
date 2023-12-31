part of '../onboard_view.dart';

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
        FluText(
          text: LocalizationConstants.onboard_chooseYourAvatar.tr(),
          size: 20,
          weight: FluTextWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: viewData.avatarAssets
                .map(
                  (e) => _ProfileAvatarSelection(
                    key: ValueKey(e),
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
                  NavigationManager.instance.goClearBackAll(des: FluNavigations.bottomBarView);
                },
          child: FluText(
            text: LocalizationConstants.onboard_continue.tr(),
            color: viewData.avatarPath.isEmpty ? ColorConstant.textBlack : ColorConstant.textWhite,
          ),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}

//*-----------------------------------------------------------------------------

class _ProfileAvatarSelection extends StatefulWidget {
  const _ProfileAvatarSelection({
    required this.itemIndex,
    required this.selectedItemIndex,
    required this.onItemSelected,
    required this.avatarPath,
    super.key,
  });

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

    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(),
      ),
      child: InkWell(
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
              right: 12,
              top: 12,
              child: AnimatedContainer(
                width: 24,
                height: 24,
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: isSelected ? ColorConstant.textBlack : ColorConstant.textWhite,
                ),
                child: isSelected
                    ? const FittedBox(
                        child: Icon(
                          Icons.check_rounded,
                          color: ColorConstant.textWhite,
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

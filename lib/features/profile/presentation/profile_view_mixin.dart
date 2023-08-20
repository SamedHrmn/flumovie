import 'package:easy_localization/easy_localization.dart';
import 'package:flumovie/core/components/custom/flutext.dart';
import 'package:flumovie/core/util/localization_manager.dart';
import 'package:flumovie/core/util/navigation/navigation_manager.dart';
import 'package:flumovie/features/profile/presentation/profile_view.dart';
import 'package:flutter/material.dart';

mixin ProfileViewMixin on State<ProfileView> {
  void showMenuWithDynamicPosition(BuildContext context, {required Map<String, List<String>> menuItems}) {
    final button = context.findRenderObject() as RenderBox?;
    if (button == null) return;

    final offset = button.localToGlobal(Offset(0, button.size.height));
    final position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy,
      offset.dx + button.size.width,
      offset.dy,
    );

    final menuEntries = menuItems.entries.map((entry) {
      final submenuItems = entry.value.map((subItem) {
        return PopupMenuItem<String>(
          value: subItem,
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: context.locale.languageCode.toUpperCase() == subItem ? Colors.green : Colors.transparent,
                size: 12,
              ),
              MenuItemButton(
                onPressed: () async {
                  await LocalizationManager.instance.changeLanguage(context, Locale.fromSubtags(languageCode: subItem.toLowerCase()));

                  await NavigationManager.instance.goClearBackAll(des: FluNavigations.bottomBarView);
                },
                child: FluText(text: subItem),
              ),
            ],
          ),
        );
      }).toList();

      return PopupMenuItem<String>(
        value: entry.key,
        padding: EdgeInsets.zero,
        child: SubmenuButton(
          menuChildren: submenuItems,
          alignmentOffset: Offset(-button.size.width, 24),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: FluText(text: entry.key),
        ),
      );
    }).toList();

    showMenu<void>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      items: menuEntries,
    );
  }
}

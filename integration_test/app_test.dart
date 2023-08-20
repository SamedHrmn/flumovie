import 'package:easy_localization/easy_localization.dart';
import 'package:flumovie/core/components/custom/flu_primary_button.dart';
import 'package:flumovie/core/constants/localization_constant.dart';
import 'package:flumovie/core/gen/assets.gen.dart';
import 'package:flumovie/core/util/flu_cubit.dart';
import 'package:flumovie/core/util/localization_manager.dart';
import 'package:flumovie/core/util/navigation/navigation_observer.dart';
import 'package:flumovie/features/entry/flu_bottombar_view.dart';
import 'package:flumovie/features/entry/onboard/onboard_cubit.dart';
import 'package:flumovie/features/entry/onboard/onboard_dto.dart';
import 'package:flumovie/main.dart';
import 'package:flumovie/shared/s_cubit/page_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  dotenv.testLoad();
  await LocalizationManager.instance.initLocalization();
  await FluCubit.init(dir: await getApplicationDocumentsDirectory());

  final onboardCubit = OnBoardCubit(
    viewData: OnboardDTO(
      avatarAssets: [
        Assets.icons.avatar1.path,
        Assets.icons.avatar2.path,
        Assets.icons.avatar3.path,
        Assets.icons.avatar4.path,
      ],
    ),
  );
  final pageManagerCubit = PageManagerCubit();
  const mockNickName = 'Hello';
  final navObserver = FluNavigationObserver();
  final rootWidget = EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('tr')],
    useOnlyLangCode: true,
    path: 'assets/translations',
    child: MyApp(navigatorObserver: navObserver),
  );

  group('Onboard to home test:', () {
    Future<void> initOnboard(WidgetTester tester) async {
      await Future<void>.delayed(const Duration(seconds: 2));
      await tester.pumpWidget(rootWidget);
      await tester.pumpAndSettle();
    }

    testWidgets(
      'Input nickname, select avatar, check some localize texts and navigate home',
      (widgetTester) async {
        await initOnboard(widgetTester);
        //* Check Onboard initial page (NickNamePage) has a nickname input title
        expect(find.text(LocalizationConstants.onboard_howCanWeCallYou.tr()), findsOneWidget);

        //* Verify that the user's nickname is updated correctly in the OnboardCubit state.
        final nickNameFieldFinder = find.byType(TextField);
        await widgetTester.enterText(nickNameFieldFinder, mockNickName);
        await widgetTester.pumpAndSettle();
        onboardCubit.updateNickName(mockNickName);
        await widgetTester.pumpAndSettle();
        expect(onboardCubit.state.nickName, mockNickName);

        //* Tap FluPrimaryButton in Onboard nickname page and navigate to second page via PageManager
        final nickNameNextButtonFinder = find.byType(FluPrimaryButton);
        await widgetTester.tap(nickNameNextButtonFinder);
        pageManagerCubit.updateOnboardSecondPage(true);
        await widgetTester.pump(const Duration(milliseconds: 300));
        await widgetTester.pumpAndSettle();
        expect(pageManagerCubit.state.onboardIsSecondPageActive, true);

        //* Verify that the user's nickname is updated correctly in the OnboardCubit state.
        final avatarSelectionFinder = find.byKey(ValueKey(onboardCubit.state.avatarAssets[0]));
        await widgetTester.tap(avatarSelectionFinder);
        onboardCubit.updateAvatarPath(0);
        await widgetTester.pumpAndSettle();
        expect(onboardCubit.state.avatarPath, onboardCubit.state.avatarAssets[0]);
        //* Tap FluPrimaryButton in Onboard avatar page and navigate to FluBottomBarView.
        final avatarPageNextButtonFinder = find.byType(FluPrimaryButton);
        await widgetTester.tap(avatarPageNextButtonFinder);
        await widgetTester.pumpAndSettle();

        //* Check current page is FluBottomBarView
        expect(find.byType(FluBottomBarView), findsOneWidget, reason: 'Home');
        //* Check FluBottomBarView initial page (Home) has an Upcoming movies feature title
        expect(find.text(LocalizationConstants.home_upcomingMovies.tr()), findsOneWidget, reason: 'Upcoming movies');
      },
    );
  });
}

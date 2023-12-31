import 'package:easy_localization/easy_localization.dart';
import 'package:flumovie/core/api/dio_api_client.dart';
import 'package:flumovie/core/gen/assets.gen.dart';
import 'package:flumovie/core/util/flu_cubit.dart';
import 'package:flumovie/core/util/localization_manager.dart';
import 'package:flumovie/core/util/navigation/navigation_manager.dart';
import 'package:flumovie/core/util/navigation/navigation_observer.dart';
import 'package:flumovie/features/detail/application/cubit/add_favorite_cubit.dart';
import 'package:flumovie/features/detail/application/cubit/movie_detail_cubit.dart';
import 'package:flumovie/features/entry/onboard/onboard_cubit.dart';
import 'package:flumovie/features/entry/onboard/onboard_dto.dart';
import 'package:flumovie/features/home/popular/application/cubit/popular_movie_cubit.dart';
import 'package:flumovie/features/home/upcoming/application/cubit/upcoming_movies_cubit.dart';
import 'package:flumovie/features/profile/application/profile_cubit.dart';
import 'package:flumovie/features/profile/application/profile_dto.dart';
import 'package:flumovie/features/search/application/cubit/movie_search_cubit.dart';
import 'package:flumovie/shared/s_cubit/page_manager_cubit.dart';
import 'package:flumovie/shared/s_data/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      useOnlyLangCode: true,
      path: 'assets/translations',
      child: MyApp(
        navigatorObserver: FluNavigationObserver(),
      ),
    ),
  );
}

Future<void> initApp() async {
  await Future.wait([
    dotenv.load(),
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]),
    LocalizationManager.instance.initLocalization(),
  ]);

  await FluCubit.init(dir: await getApplicationDocumentsDirectory());
}

//*-----------------------------------------------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({required this.navigatorObserver, super.key});

  final NavigatorObserver navigatorObserver;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopularMovieCubit(
            movieRepository: MovieRepository(
              client: DioApiClient(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => MovieDetailCubit(
            movieRepository: MovieRepository(
              client: DioApiClient(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => MovieSearchCubit(
            movieRepository: MovieRepository(
              client: DioApiClient(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AddFavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => OnBoardCubit(
            viewData: OnboardDTO(
              avatarAssets: [
                Assets.icons.avatar1.path,
                Assets.icons.avatar2.path,
                Assets.icons.avatar3.path,
                Assets.icons.avatar4.path,
              ],
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(profileDTO: const ProfileDTO()),
        ),
        BlocProvider(
          create: (context) => UpcomingMoviesCubit(
            movieRepository: MovieRepository(
              client: DioApiClient(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => PageManagerCubit(),
        ),
      ],
      child: materialApp(context),
    );
  }

  MaterialApp materialApp(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      navigatorKey: NavigationManager.navigatorKey,
      navigatorObservers: [
        navigatorObserver,
      ],
      home: FluNavigations.onboardView.toPage(),
    );
  }
}

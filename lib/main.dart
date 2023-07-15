import 'package:flumovie/core/api/api_client.dart';
import 'package:flumovie/core/api/movie_api_helper.dart';
import 'package:flumovie/features/detail/application/cubit/movie_detail_cubit.dart';
import 'package:flumovie/features/popular/application/cubit/popular_movie_cubit.dart';
import 'package:flumovie/features/popular/presentation/movie_home_view.dart';
import 'package:flumovie/shared/s_data/dio_movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopularMovieCubit(
              dioMovieRepository: DioMovieRepository(
                client: ApiClient(),
                apiHelper: MovieApiHelper(
                  apiKey: dotenv.get('API_KEY'),
                ),
              ),
              clearCache: true),
        ),
        BlocProvider(
          create: (context) => MovieDetailCubit(
            dioMovieRepository: DioMovieRepository(
              client: ApiClient(),
              apiHelper: MovieApiHelper(
                apiKey: dotenv.get('API_KEY'),
              ),
            ),
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MovieHomeView(),
      ),
    );
  }
}

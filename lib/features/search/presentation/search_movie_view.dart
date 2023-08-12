import 'package:flumovie/core/components/custom/flu_icon_button.dart';
import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/components/custom/flutext.dart';
import 'package:flumovie/core/util/navigation/navigation_manager.dart';
import 'package:flumovie/features/search/application/cubit/movie_search_cubit.dart';
import 'package:flumovie/features/search/application/cubit/movie_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMovieView extends StatefulWidget {
  const SearchMovieView({super.key});

  @override
  State<SearchMovieView> createState() => _SearchMovieViewState();
}

class _SearchMovieViewState extends State<SearchMovieView> {
  String searchString = '';

  void updateSearchString(String v) {
    setState(() {
      searchString = v;
    });
  }

  @override
  void initState() {
    super.initState();
    searchString = context.read<MovieSearchCubit>().state.queryString ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final searchState = context.select<MovieSearchCubit, MovieSearchState>(
      (value) => value.state,
    );
    final isSearchLoading = searchState.status == MovieSearchStatus.loading;
    final isSearchSuccess = searchState.status == MovieSearchStatus.success;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: updateSearchString,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              FluIconButton(
                icon: FluIcon.search,
                onPressedAsync: isSearchLoading
                    ? null
                    : () async {
                        if (searchString.isEmpty) {
                          return;
                        }

                        await context.read<MovieSearchCubit>().searchMovie(title: searchString);
                      },
              ),
            ],
          ),
        ),
        if (isSearchSuccess) FluText(text: 'Search result for: ${searchState.queryString}') else const SizedBox.shrink(),
        const Expanded(child: _SearchMovieResults()),
      ],
    );
  }
}

class _SearchMovieResults extends StatelessWidget {
  const _SearchMovieResults();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieSearchCubit, MovieSearchState>(
      builder: (context, state) {
        switch (state.status) {
          case MovieSearchStatus.initial:
            return const SizedBox();
          case MovieSearchStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case MovieSearchStatus.noResult:
            return const FluText(text: 'No result :(');
          case MovieSearchStatus.failure:
            return const FluText(text: 'An Error Occured!');
          case MovieSearchStatus.success:
            return GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 24),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 220,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: state.movieSearchDTO!.movieSearch!.results!.length,
              itemBuilder: (context, index) {
                final model = state.movieSearchDTO!.movieSearch!.results![index];

                return GestureDetector(
                  onTap: () => NavigationManager.instance.go(
                    des: FluNavigations.movieDetailView,
                    param: model.id,
                  ),
                  child: SizedBox(
                    width: 100,
                    height: 220,
                    child: Column(
                      children: [
                        Expanded(
                          child: FluNetworkImage(
                            url: model.posterPath,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }
}

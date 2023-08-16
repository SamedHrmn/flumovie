import 'package:easy_localization/easy_localization.dart';
import 'package:flumovie/core/components/custom/flu_icon_button.dart';
import 'package:flumovie/core/components/custom/flu_network_image.dart';
import 'package:flumovie/core/components/custom/flutext.dart';
import 'package:flumovie/core/constants/color_constant.dart';
import 'package:flumovie/core/constants/localization_constant.dart';
import 'package:flumovie/core/gen/fonts.gen.dart';
import 'package:flumovie/core/util/navigation/navigation_manager.dart';
import 'package:flumovie/features/search/application/cubit/movie_search_cubit.dart';
import 'package:flumovie/features/search/application/cubit/movie_search_state.dart';
import 'package:flumovie/features/search/application/movie_search_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widget/search_result_card.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
          child: Row(
            children: [
              Expanded(
                child: searchTextField(),
              ),
              searchButton(isSearchLoading: isSearchLoading),
            ],
          ),
        ),
        searchResultText(isSearchSuccess: isSearchSuccess, text: searchState.queryString),
        const Expanded(
          child: _SearchMovieResults(),
        ),
      ],
    );
  }

  Widget searchResultText({required bool isSearchSuccess, required String? text}) {
    return isSearchSuccess && text != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: FluText(text: LocalizationConstants.search_resultFor.tr(args: [text])),
          )
        : const SizedBox.shrink();
  }

  FluIconButton searchButton({required bool isSearchLoading}) {
    return FluIconButton(
      icon: FluIcon.search,
      onPressedAsync: isSearchLoading
          ? null
          : () async {
              if (searchString.isEmpty) {
                return;
              }

              await context.read<MovieSearchCubit>().searchMovie(title: searchString);
            },
    );
  }

  TextField searchTextField() {
    return TextField(
      onChanged: updateSearchString,
      decoration: InputDecoration(
        hintText: LocalizationConstants.search_textFieldHint.tr(),
        hintStyle: const TextStyle(
          fontFamily: FontFamily.roboto,
          fontWeight: FontWeight.w400,
          color: ColorConstant.textBlack,
          fontSize: 14,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

//*-----------------------------------------------------------------------------

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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: FluText(text: LocalizationConstants.search_noResult.tr()),
            );
          case MovieSearchStatus.failure:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: FluText(text: LocalizationConstants.error_type1.tr()),
            );
          case MovieSearchStatus.success:
            return _SearchResultGrid(
              movieSearchDTO: state.movieSearchDTO!,
            );
        }
      },
    );
  }
}

//*-----------------------------------------------------------------------------

class _SearchResultGrid extends StatelessWidget {
  const _SearchResultGrid({required this.movieSearchDTO});

  final MovieSearchDTO movieSearchDTO;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 24),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 220,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: movieSearchDTO.movieSearchDetails.length,
      itemBuilder: (context, index) {
        final model = movieSearchDTO.movieSearchDetails[index];

        return _SearchResultCard(movieSearchDetail: model);
      },
    );
  }
}

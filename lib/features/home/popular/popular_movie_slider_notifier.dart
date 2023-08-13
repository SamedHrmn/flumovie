part of 'presentation/popular_movie_slider.dart';

class _PopularMovieSliderData {
  const _PopularMovieSliderData(this.imageUrlColors, this.activeIndex);

  final Map<String?, Color> imageUrlColors;
  final int activeIndex;

  _PopularMovieSliderData copyWith({
    Map<String?, Color>? imageUrlColors,
    int? activeIndex,
  }) {
    return _PopularMovieSliderData(
      imageUrlColors ?? this.imageUrlColors,
      activeIndex ?? this.activeIndex,
    );
  }
}

class _PopularMovieSliderNotifier extends ValueNotifier<_PopularMovieSliderData> {
  _PopularMovieSliderNotifier() : super(const _PopularMovieSliderData({}, 0));

  Future<void> computeImageColors(List<PopularMovieDetail> popularMovies) async {
    final localMap = <String?, Color>{};

    for (final movie in popularMovies) {
      if (!value.imageUrlColors.containsKey(movie.imageUrl)) {
        final paletteGenerator = await PaletteGenerator.fromImageProvider(
          FluNetworkImage.withImageProvider(url: movie.imageUrl),
          maximumColorCount: 5,
        );
        if (paletteGenerator.dominantColor != null) {
          localMap[movie.imageUrl] = paletteGenerator.dominantColor!.color;
          value = value.copyWith(imageUrlColors: localMap);
        } else {
          localMap[movie.imageUrl] = ColorConstant.scaffoldBackgroundColor;
          value = value.copyWith(imageUrlColors: localMap);
        }
      }
    }
  }

  void updateIndex(int i) {
    value = value.copyWith(activeIndex: i);
  }

  Color getBackgroundColorFromImage(List<PopularMovieDetail> popularMovies) =>
      value.imageUrlColors[popularMovies[value.activeIndex].imageUrl] ?? ColorConstant.scaffoldBackgroundColor;
}

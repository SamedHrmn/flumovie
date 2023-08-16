import 'package:flumovie/core/util/flu_cubit.dart';
import 'package:flumovie/features/detail/application/cubit/favorites_state.dart';
import 'package:flumovie/features/detail/domain/movie_detail.dart';

class AddFavoriteCubit extends FluCubit<FavoritesState> {
  AddFavoriteCubit() : super(const FavoritesState(favorites: []));

  void addFavorite({required MovieDetail movieDetail}) {
    final favorites = state.favorites.toList();

    if (favorites.firstWhere((element) => element.id == movieDetail.id, orElse: MovieDetail.new).id != null) {
      favorites.removeWhere((element) => element.id == movieDetail.id);
      emit(state.copyWith(favorites: favorites));
    } else {
      favorites.add(movieDetail);
      emit(state.copyWith(favorites: favorites));
    }
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    return FavoritesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FavoritesState state) {
    return state.toJson();
  }
}

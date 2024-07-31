import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_apps/models/movie.dart';

class FavoritesMovieProvider extends StateNotifier<List<Movie>> {
  FavoritesMovieProvider(): super([]);

  bool toogleFavorite (Movie movie) {
    final movieIsFavorited = state.contains(movie);

    if (movieIsFavorited) {
        state = state.where((element) => element.id != movie.id,).toList();
        return true;
    } else {
      state = [...state, movie];
        return false;
    }
  }
}

final favoritesMovieProvider = StateNotifierProvider<FavoritesMovieProvider, List<Movie>>((ref) {
  return FavoritesMovieProvider();
});
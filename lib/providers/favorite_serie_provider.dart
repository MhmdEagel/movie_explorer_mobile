import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_apps/models/serie.dart';

class FavoriteSerieProvider extends StateNotifier<List<Serie>> {
  FavoriteSerieProvider(): super([]);
  

  bool toogleFavorite (Serie serie) {
    final serieIsFavorited = state.contains(serie);

    if (serieIsFavorited) {
        state = state.where((element) => element.id != serie.id,).toList();
        return true;
    } else {
      state = [...state, serie];
      return false;
    }
  }
}

final favoriteSerieProvider = StateNotifierProvider<FavoriteSerieProvider, List<Serie>>((ref) {
  return FavoriteSerieProvider();
});
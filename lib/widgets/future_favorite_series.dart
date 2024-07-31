import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie_apps/providers/favorite_serie_provider.dart';
import 'package:movie_apps/widgets/fav_alt_text.dart';
import 'package:movie_apps/widgets/movie_list_grid.dart';

class FutureFavoriteSeries extends ConsumerStatefulWidget {
  const FutureFavoriteSeries({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FutureFavoriteSeriesState();
}

class _FutureFavoriteSeriesState extends ConsumerState<FutureFavoriteSeries> {
late Future<void> _seriesFuture;

  @override
  void initState() {
    super.initState();
    _seriesFuture = ref.read(favoriteSerieProvider.notifier).loadSeries();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteSeries = ref.watch(favoriteSerieProvider);
    return FutureBuilder(
      future: _seriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.stretchedDots(
              color: Theme.of(context).colorScheme.secondary,
              size: 30,
            ),
          );
        } else {
          if(favoriteSeries.isEmpty) {
            return const FavAltText();
          }
          return MovieListGrid(series: favoriteSeries,);
        }
      },
    );
  }
}
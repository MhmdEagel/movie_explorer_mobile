import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie_apps/providers/favorite_movie_provider.dart';
import 'package:movie_apps/widgets/fav_alt_text.dart';
import 'package:movie_apps/widgets/movie_list_grid.dart';

class FutureFavoriteMovies extends ConsumerStatefulWidget {
  const FutureFavoriteMovies({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FutureFavoriteMoviesState();
}

class _FutureFavoriteMoviesState extends ConsumerState<FutureFavoriteMovies> {
  late Future<void> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = ref.read(favoritesMovieProvider.notifier).loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoritesMovieProvider);
    return FutureBuilder(
      future: _moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.stretchedDots(
              color: Theme.of(context).colorScheme.secondary,
              size: 30,
            ),
          );
        } else {
          
          return MovieListGrid(movies: favoriteMovies,);
        }
      },
    );
  }
}

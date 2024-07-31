import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_apps/providers/favorite_movie_provider.dart';
import 'package:movie_apps/providers/favorite_serie_provider.dart';
import 'package:movie_apps/widgets/movie_list_grid.dart';

class Favorite extends ConsumerWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMovies = ref.watch(favoritesMovieProvider);
    final favoriteSeries = ref.watch(favoriteSerieProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Favorite Movies",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            favoriteMovies.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Text(
                          "There is nothing to show here",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        Text(
                          "Try add some movies",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  )
                : MovieListGrid(
                    movies: favoriteMovies,
                  ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Favorite TV Series",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15,),
            favoriteSeries.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Text(
                          "There is nothing to show here",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        Text(
                          "Try add some tv series",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  )
                : MovieListGrid(
                    series: favoriteSeries,
                  ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

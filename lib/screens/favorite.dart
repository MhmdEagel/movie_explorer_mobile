import 'package:flutter/material.dart';
import 'package:movie_apps/widgets/future_favorite_movies.dart';
import 'package:movie_apps/widgets/future_favorite_series.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
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
            const FutureFavoriteMovies(),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Favorite TV Series",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const FutureFavoriteSeries(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

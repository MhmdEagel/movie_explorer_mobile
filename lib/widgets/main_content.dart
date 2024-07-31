import 'package:flutter/material.dart';
import 'package:movie_apps/models/movie.dart';
import 'package:movie_apps/models/serie.dart';
import 'package:movie_apps/screens/movie_detail_list.dart';
import 'package:movie_apps/widgets/movie_list.dart';



class MainContent extends StatelessWidget {
  const MainContent(
      {super.key,
      required this.nowPlayingMovies,
      required this.topRatedMovies,
      required this.tvSeries});

  final List<Movie> nowPlayingMovies;
  final List<Movie> topRatedMovies;
  final List<Serie> tvSeries;

  void _viewAllMovies(
    String title,
    List<Movie>? movies,
    List<Serie>? series,
    BuildContext context,
  ) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          MovieDetailList(title: title, movies: movies, series: series),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Now Playing",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    _viewAllMovies(
                        "Now Playing", nowPlayingMovies, [], context);
                  },
                  label: const Text("VIEW ALL"),
                  icon: const Icon(Icons.arrow_forward),
                  iconAlignment: IconAlignment.end,
                )
              ],
            ),
            Text(
              "Find movies that played recently in cinema",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            MovieList(
              movies: nowPlayingMovies,
              listDirection: Axis.horizontal,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  "Top Rated Movies",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    _viewAllMovies(
                        "Top Rated Movies", topRatedMovies, [], context);
                  },
                  label: const Text("VIEW ALL"),
                  icon: const Icon(Icons.arrow_forward),
                  iconAlignment: IconAlignment.end,
                )
              ],
            ),
            Text(
              "Find movies that get the most reviews",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            MovieList(
              movies: topRatedMovies,
              listDirection: Axis.horizontal,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  "Top Rated TV Series",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    _viewAllMovies(
                      "Top Rated TV Series",
                      null,
                      tvSeries,
                      context,
                    );
                  },
                  label: const Text("VIEW ALL"),
                  icon: const Icon(Icons.arrow_forward),
                  iconAlignment: IconAlignment.end,
                )
              ],
            ),
            Text(
              "Find TV Shows that get the most reviews",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            MovieList(
              series: tvSeries,
              listDirection: Axis.horizontal,
            ),
          ],
        ),
      ),
    );
  }
}

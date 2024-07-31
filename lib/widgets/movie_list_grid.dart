import 'package:flutter/material.dart';
import 'package:movie_apps/models/movie.dart';
import 'package:movie_apps/models/serie.dart';
import 'package:movie_apps/widgets/movie_item.dart';
import 'package:movie_apps/widgets/serie_item.dart';

class MovieListGrid extends StatelessWidget {
  const MovieListGrid({super.key, this.movies, this.series});

  final List<Movie>? movies;
  final List<Serie>? series;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        childAspectRatio: 0.65
      ),
      itemCount: movies != null ? movies!.length : series!.length,
      itemBuilder: (context, index) {
        if (movies != null) {
          final Movie movie = movies![index];
          return MovieItem(
            movie: movie,
          );
        } else {
          final Serie serie = series![index];
          return SerieItem(serie: serie);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_apps/models/movie.dart';
import 'package:movie_apps/models/serie.dart';
import 'package:movie_apps/widgets/movie_item.dart';
import 'package:movie_apps/widgets/serie_item.dart';

class MovieList extends StatelessWidget {
  const MovieList(
      {super.key, required this.listDirection, this.movies, this.series});

  final List<Movie>? movies;
  final List<Serie>? series;
  final Axis listDirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: listDirection,
              itemCount: movies != null ? movies!.length : series!.length,
              itemBuilder: (context, index) {
                if (movies != null) {
                  final Movie movie = movies![index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: MovieItem(movie: movie),
                  );
                } else {
                  final Serie serie = series![index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SerieItem(serie: serie),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

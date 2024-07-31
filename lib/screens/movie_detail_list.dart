import 'package:flutter/material.dart';
import 'package:movie_apps/widgets/movie_list_grid.dart';
import 'package:movie_apps/models/movie.dart';
import 'package:movie_apps/models/serie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_apps/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MovieDetailList extends StatefulWidget {
  const MovieDetailList(
      {super.key,
      required this.title,
      required this.movies,
      required this.series});

  final String title;
  final List<Movie>? movies;
  final List<Serie>? series;

  @override
  State<MovieDetailList> createState() => _MovieDetailListState();
}

class _MovieDetailListState extends State<MovieDetailList> {
  var _selectedPages = 1;
  var _isLoading = false;
  List<Movie>? _allMovies;
  List<Serie>? _allSeries;

  void _onSelectPageNumber(int pageNumber) {
    setState(() {
      _selectedPages = pageNumber;
      if (pageNumber > 1) _isLoading = true;
    });
    _loadMovies(pageNumber);
  }

  void _loadMovies(int pageNumber) async {
    if (pageNumber == 1) {
      setState(() {
        _allMovies = null;
        _allSeries = null;
      });
      return;
    }

    Uri? urlMovies;
    Uri? urlSeries;

    if (widget.title == "Now Playing") {
      urlMovies = Uri.https('api.themoviedb.org', '3/movie/now_playing',
          {'api_key': apiKey, 'page': pageNumber.toString()});
    } else {
      urlMovies = Uri.https('api.themoviedb.org', '3/movie/top_rated',
          {'api_key': apiKey, 'page': pageNumber.toString()});
    }

    if (widget.title == "Top Rated TV Series") {
      urlSeries = Uri.https('api.themoviedb.org', '3/tv/top_rated',
          {'api_key': apiKey, 'page': pageNumber.toString()});
    }

    if (urlSeries != null) {
      final responseSeries = await http.get(urlSeries);
      final loadedSeries = jsonDecode(responseSeries.body)["results"];
      setState(() {
        _isLoading = false;
      });

      final List<Serie> loadedSerieList = [];
      for (final serie in loadedSeries) {
        loadedSerieList.add(Serie.fromJson(serie));
      }
      setState(() {
        _allSeries = loadedSerieList;
      });
      return;
    }

    final responseMovies = await http.get(urlMovies);
    final loadedMovies = jsonDecode(responseMovies.body)["results"];
    setState(() {
      _isLoading = false;
    });
    final List<Movie> loadedMovieList = [];
    for (final movie in loadedMovies) {
      loadedMovieList.add(Movie.fromJson(movie));
    }
    setState(() {
      _allMovies = loadedMovieList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = LoadingAnimationWidget.stretchedDots(
        color: Theme.of(context).colorScheme.secondary, size: 100);

    if (!_isLoading) {
      content = MovieListGrid(
        movies: _allMovies ?? widget.movies,
        series: _allSeries ?? widget.series,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 1; i < 7; i++)
                    TextButton(
                      onPressed: () {
                        _onSelectPageNumber(i);
                      },
                      child: Text(
                        i.toString(),
                        style: i == _selectedPages
                            ? Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold)
                            : Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              content,
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

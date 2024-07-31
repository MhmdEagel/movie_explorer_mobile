import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_apps/main.dart';
import 'package:movie_apps/models/movie.dart';
import 'package:movie_apps/models/serie.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie_apps/widgets/main_content.dart';


class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Serie> _tvSeries = [];
  String? _errorMsg;
  bool _isLoading = true;

  void _loadMovies() async {
    final urlNowPlaying = Uri.https(
        'api.themoviedb.org', '3/movie/now_playing', {'api_key': apiKey});

    final urlTopRated = Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=5e33d1e946697b6fa2f1aa36f86f1445");

    final urlTvSeries =
        Uri.https('api.themoviedb.org', '3/tv/top_rated', {'api_key': apiKey});

    final responseNowPlaying = await http.get(urlNowPlaying);
    final responseTopRated = await http.get(urlTopRated);
    final responseTvSeries = await http.get(urlTvSeries);

    final nowPlayingResults = jsonDecode(responseNowPlaying.body)["results"];
    final topRatedResults = jsonDecode(responseTopRated.body)["results"];
    final tvSeriesResults = jsonDecode(responseTvSeries.body)["results"];

    setState(() {
      _isLoading = false;
    });

    if (responseNowPlaying.statusCode >= 400 ||
        responseTopRated.statusCode >= 400 ||
        responseTvSeries.statusCode >= 400) {
      setState(() {
        _errorMsg = "Something went wrong. Try again Later";
        return;
      });
    }
    final List<Movie> nowPlayingMovies = [];
    final List<Movie> topRatedMovies = [];
    final List<Serie> tvSeries = [];

    for (final movie in nowPlayingResults) {
      nowPlayingMovies.add(Movie.fromJson(movie));
    }

    for (final movie in topRatedResults) {
      topRatedMovies.add(Movie.fromJson(movie));
    }

    for (final serie in tvSeriesResults) {
      tvSeries.add(Serie.fromJson(serie));
    }

    setState(() {
      _nowPlayingMovies = nowPlayingMovies;
      _topRatedMovies = topRatedMovies;
      _tvSeries = tvSeries;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("Failed to fetch data"),
    );

    if (_isLoading) {
      content = Center(
        child: LoadingAnimationWidget.stretchedDots(
            color: Theme.of(context).colorScheme.secondary, size: 100),
      );
    } else {
      if (_errorMsg != null) {
        content = Center(
          child: Text(
            _errorMsg!,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        );
      }
      if (_nowPlayingMovies.isNotEmpty) {
        content = MainContent(
          nowPlayingMovies: _nowPlayingMovies,
          topRatedMovies: _topRatedMovies,
          tvSeries: _tvSeries,
        );
      }
    }

    return content;
  }
}


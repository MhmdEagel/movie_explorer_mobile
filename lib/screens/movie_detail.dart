import 'dart:convert';
import 'package:movie_apps/providers/favorite_movie_provider.dart';
import 'package:movie_apps/widgets/trailer_player.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/main.dart';
import 'package:movie_apps/models/movie.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetail extends ConsumerStatefulWidget {
  const MovieDetail({super.key, required this.movie});

  final Movie movie;

  @override
  ConsumerState<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends ConsumerState<MovieDetail> {
  late String _youtubeWatchKey = "";
  List? allGenre;

  void _loadVideo() async {
    final url = Uri.https('api.themoviedb.org',
        '3/movie/${widget.movie.id}/videos', {'api_key': apiKey});
    final response = await http.get(url);
    List filteredVideos = [];
    final List loadedVideo = jsonDecode(response.body)["results"];

    if (response.statusCode == 200) {
      filteredVideos = loadedVideo
          .where(
            (element) => element["type"] == "Trailer",
          )
          .toList();
    }

    setState(() {
      _youtubeWatchKey = filteredVideos[0]["key"].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadVideo();
    setState(() {
      allGenre = genre
          .where(
            (element) => widget.movie.genreIds.contains(element["id"]),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMovieFavorited =
        ref.watch(favoritesMovieProvider).contains(widget.movie);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            onPressed: () {
              final isFavorited = ref
                  .read(favoritesMovieProvider.notifier)
                  .toogleFavorite(widget.movie);
              if (isFavorited) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Movie removed from the favorite list!"),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Movie added to the favorite list!"),
                  ),
                );
              }
            },
            icon:  Icon(isMovieFavorited ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 50,
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color.fromARGB(255, 27, 26, 26),
                height: 400,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(
                    "https://image.tmdb.org/t/p/w342/${widget.movie.posterPath}",
                  ),
                  fadeInDuration: const Duration(milliseconds: 500),
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.movie.title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.movie.voteAverage.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(Icons.trending_up),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.movie.voteCount.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  for (final item in allGenre!)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: item["color"]),
                          child: Text(
                            item["name"],
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold),
                          )),
                    ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Trailer",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              if (_youtubeWatchKey == "")
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 200,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                )
              else
                TrailerPlayer(youtubeId: _youtubeWatchKey),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Overview",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.movie.overview,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }
}

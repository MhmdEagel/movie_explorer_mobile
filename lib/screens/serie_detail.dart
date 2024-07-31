import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_apps/main.dart';
import 'package:movie_apps/models/movie.dart';
import 'package:movie_apps/models/serie.dart';
import 'package:movie_apps/providers/favorite_serie_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:movie_apps/widgets/trailer_player.dart';
import 'package:http/http.dart' as http;

class SerieDetail extends ConsumerStatefulWidget {
  const SerieDetail({super.key, required this.serie});

  final Serie serie;

  @override
  ConsumerState<SerieDetail> createState() => _SerieDetailState();
}

class _SerieDetailState extends ConsumerState<SerieDetail> {
  late String _youtubeWatchKey = "";
  List? allGenre;

  void _loadVideo() async {
    final url = Uri.https('api.themoviedb.org',
        '3/tv/${widget.serie.id}/videos', {'api_key': apiKey});
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
            (element) => widget.serie.genreIds.contains(element["id"]),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSerieFavorited =
        ref.watch(favoriteSerieProvider).contains(widget.serie);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.serie.name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            onPressed: () async {
              final isFavorited = await ref
                  .read(favoriteSerieProvider.notifier)
                  .toogleFavorite(widget.serie);

              if (isFavorited) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Serie removed from the favorite list!"),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Serie added to the favorite list!"),
                  ),
                );
              }
            },
            icon: Icon(isSerieFavorited ? Icons.star : Icons.star_border),
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
                    "https://image.tmdb.org/t/p/w342/${widget.serie.posterPath}",
                  ),
                  fadeInDuration: const Duration(milliseconds: 500),
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.serie.name,
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
                    widget.serie.voteAverage.toStringAsFixed(1),
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
                    widget.serie.voteCount.toString(),
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
                widget.serie.overview,
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

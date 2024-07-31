import 'package:flutter/material.dart';
import 'package:movie_apps/models/movie.dart';
import 'package:movie_apps/screens/movie_detail.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie,this.imageWidth});
  final Movie movie;
  final double? imageWidth;

  void _onTapMovie (BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail(movie: movie),));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onTapMovie(context);
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: 200,
              height: 300,
              child: Center(
                child: LoadingAnimationWidget.horizontalRotatingDots(
                    color: Theme.of(context).colorScheme.secondary, size: 30),
              ),
            ),
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(
                "https://image.tmdb.org/t/p/w342${movie.posterPath}",
              ),
              fadeInDuration: const Duration(milliseconds: 500),
              width: imageWidth ?? 200,
            ),
          ],
        ),
      ),
    );
  }
}

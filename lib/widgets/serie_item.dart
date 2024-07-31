import 'package:flutter/material.dart';
import 'package:movie_apps/models/serie.dart';
import 'package:movie_apps/screens/serie_detail.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SerieItem extends StatelessWidget {
  const SerieItem({super.key, required this.serie});
  final Serie serie;

  void _onTapSerie(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SerieDetail(
            serie: serie,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onTapSerie(context);
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(children: [
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
              "https://image.tmdb.org/t/p/w342${serie.posterPath}",
            ),
            width: 200,
          ),
        ]),
      ),
    );
  }
}

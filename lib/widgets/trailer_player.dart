import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayer extends StatefulWidget {
  const TrailerPlayer({super.key, required this.youtubeId});

  final String youtubeId;

  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: false,
        enableCaption: true
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Theme.of(context).colorScheme.secondary,
      progressColors: ProgressBarColors(
        playedColor: Theme.of(context).colorScheme.secondary,
        handleColor: Colors.tealAccent,
      ),
    );
  }
}

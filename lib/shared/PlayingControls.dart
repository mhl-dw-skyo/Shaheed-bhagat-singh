import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final LoopMode loopMode;
  final bool isPlaylist;
  final Function() onPrevious;
  final Function() onPlay;
  final Function() onNext;
  final Function() toggleLoop;
  final Function() onStop;

  PlayingControls({
    this.isPlaying,
    this.isPlaylist = false,
    this.loopMode,
    this.toggleLoop,
    this.onPrevious,
    this.onPlay,
    this.onNext,
    this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isPlaying ? "assets/images/pause.svg" : "assets/images/play.svg",
      width: 30,
      height: 30,
    );
  }
}

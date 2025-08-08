import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final AudioPlayer audioPlayer;
  const PlayPauseButton(
      {super.key, required this.isPlaying, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle, size: 50),
      onPressed: () async {
        if (isPlaying) {
          await audioPlayer.pause();
        } else {
          await audioPlayer.resume();
        }
      },
    );
  }
}

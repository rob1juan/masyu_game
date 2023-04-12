import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioProvider extends InheritedWidget {
  final AudioPlayer audioPlayer;

  AudioProvider({required this.audioPlayer, required Widget child})
      : super(child: child);

  static AudioProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AudioProvider>();
  }

  @override
  bool updateShouldNotify(AudioProvider oldWidget) {
    return audioPlayer != oldWidget.audioPlayer;
  }
}

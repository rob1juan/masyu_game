import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class BackgroundAudio extends InheritedWidget {
  final AudioPlayer backgroundPlayer;

  BackgroundAudio({
    required this.backgroundPlayer,
    required Widget child,
  }) : super(child: child);

  static BackgroundAudio of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BackgroundAudio>()!;
  }

  @override
  bool updateShouldNotify(BackgroundAudio oldWidget) {
    return oldWidget.backgroundPlayer != backgroundPlayer;
  }
}

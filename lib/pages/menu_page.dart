import 'package:flutter/material.dart';
import 'package:masyu_game/pages/difficulty_selection_page.dart';
import 'package:masyu_game/pages/settings_page.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final backgroundPlayer = AudioPlayer();
  final buttonPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    initBackgroundAudio();
  }

  Future<void> initBackgroundAudio() async {
    if (!backgroundPlayer.playing) {
      await backgroundPlayer.setAsset('assets/music/menu.mp3');
      backgroundPlayer.setLoopMode(LoopMode.one);
      backgroundPlayer.play();
    }
  }

  void playButtonSound() {
    buttonPlayer.setAsset('assets/music/pop.mp3').then((_) {
      buttonPlayer.play();
    });
  }

  @override
  void dispose() {
    backgroundPlayer.dispose();
    buttonPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double verticalSpacing = screenHeight * 0.025;
    double topSpacing = screenHeight * 0.05;

    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          SizedBox(height: topSpacing * 4),
          ElevatedButton(
            onPressed: () {
              playButtonSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DifficultySelectionPage()),
              );
            },
            child: Text('JOUER'),
            style: YellowButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
          ElevatedButton(
            onPressed: () {
              playButtonSound();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            child: Text('OPTIONS'),
            style: WarningButton(context),
          ),
        ], true),
      ),
    );
  }
}

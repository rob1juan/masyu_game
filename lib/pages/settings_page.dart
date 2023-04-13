import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';

import 'package:masyu_game/pages/music_page.dart';
import 'package:masyu_game/pages/about.dart';
import 'package:masyu_game/pages/rules.dart';
import 'package:masyu_game/pages/menu_page.dart';

import 'package:just_audio/just_audio.dart';
import 'package:masyu_game/widgets/background_audio.dart';

class SettingsPage extends StatefulWidget {
  final ValueNotifier<bool> isPlaying;

  SettingsPage({required this.isPlaying});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final backgroundPlayer = AudioPlayer();
  final buttonPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    startBackgroundMusic();
  }

  void startBackgroundMusic() async {
    final player = BackgroundAudio.of(context).backgroundPlayer;
    final isPlaying = BackgroundAudio.of(context).isPlaying;

    if (isPlaying.value) return;

    await player.setAsset('assets/music/menu.mp3');
    player.setLoopMode(LoopMode.one);
    player.play();
    isPlaying.value = true;
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
    // Récupérer la taille de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Définir des tailles responsives pour les espacements
    double verticalSpacing = screenHeight * 0.025;
    double topSpacing = screenHeight * 0.05;

    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          SizedBox(height: topSpacing * 1.5),
          Text(
            'OPTIONS',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: verticalSpacing * 2),
          ElevatedButton(
            onPressed: () {
              playButtonSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MusicPage(isPlaying: widget.isPlaying)),
              );
            },
            child: Text('MUSIQUE'),
            style: YellowButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
          ElevatedButton(
            onPressed: () {
              playButtonSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RulesPage(isPlaying: widget.isPlaying)),
              );
            },
            child: Text('REGLES'),
            style: WarningButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
          ElevatedButton(
            onPressed: () {
              playButtonSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AboutPage(isPlaying: widget.isPlaying)),
              );
            },
            child: Text('A PROPOS'),
            style: PrimaryButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              playButtonSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MenuPage(isPlaying: widget.isPlaying)),
              );
            },
            child: Text('RETOUR'),
            style: SecondaryButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
        ], false),
      ),
    );
  }
}

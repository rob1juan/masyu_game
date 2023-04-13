import 'package:flutter/material.dart';
import 'package:masyu_game/pages/game_page.dart';
import 'package:masyu_game/pages/difficulty_selection_page.dart';
import 'package:masyu_game/widgets/game.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/pages/classement_page.dart';
import 'package:just_audio/just_audio.dart';

import 'package:just_audio/just_audio.dart';
import 'package:masyu_game/widgets/background_audio.dart';
import 'package:masyu_game/pages/music_preferences.dart';

class LevelSelectionPage extends StatefulWidget {
  final ValueNotifier<bool> isPlaying;

  LevelSelectionPage({required this.isPlaying});

  @override
  _LevelSelectionPageState createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends State<LevelSelectionPage> {
  final backgroundPlayer = AudioPlayer();
  final buttonPlayer = AudioPlayer();

  void startBackgroundMusic(bool isPlaying) async {
    final player = BackgroundAudio.of(context).backgroundPlayer;

    if (isPlaying) return;

    await player.setAsset('assets/music/menu.mp3');
    player.setLoopMode(LoopMode.one);
    player.play();
    if (!isPlaying) {
      widget.isPlaying.value = true;
    }
  }

  void playButtonSound() async {
    // Get the stored sound value and soundIsActivated state using MusicPreferences
    double soundValue = await MusicPreferences.getSoundValue();
    bool soundIsActivated = await MusicPreferences.getSoundIsActivated();

    if (soundIsActivated) {
      buttonPlayer.setVolume(soundValue / 100);
    } else {
      buttonPlayer.setVolume(0);
    }

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    startBackgroundMusic(widget.isPlaying.value);
    // Récupérer la taille de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Définir des tailles responsives pour les espacements
    double verticalSpacing = screenHeight * 0.01;
    double horizontalSpacing = screenWidth * 0.025;
    double topSpacing = screenHeight * 0.05;

    double buttonWidth = screenWidth * 0.3;
    double buttonHeight = screenHeight * 0.075;

    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          SizedBox(height: topSpacing * 1.5),
          Text(
            'CHOIX DU NIVEAU',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: topSpacing),
                  ElevatedButton(
                    onPressed: () {
                      playButtonSound();
                      widget.isPlaying.value = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GamePage(isPlaying: widget.isPlaying)),
                      );
                    },
                    child: Text('NIVEAU 1'),
                    style: PrimaryButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      playButtonSound();
                    },
                    child: Text('NIVEAU 2'),
                    style: PrimaryButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      playButtonSound();
                    },
                    child: Text('NIVEAU 3'),
                    style: PrimaryButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      playButtonSound();
                    },
                    child: Text('NIVEAU 4'),
                    style: PrimaryButton(context),
                  ),
                ],
              ),
              SizedBox(width: horizontalSpacing),
              Column(
                children: [
                  SizedBox(height: topSpacing),
                  ElevatedButton(
                    onPressed: () {
                      playButtonSound();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClassementPage(
                            level: 99,
                            isPlaying: widget.isPlaying,
                            elapsedTime: Duration(
                                seconds:
                                    0), // Change this to the actual elapsed time
                          ),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/poduim.png',
                      fit: BoxFit.cover,
                    ),
                    style: ClassementButton(context).copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, buttonHeight)),
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      playButtonSound();
                    },
                    child: Image.asset(
                      'assets/poduim.png',
                      fit: BoxFit.cover,
                    ),
                    style: ClassementButton(context).copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, buttonHeight)),
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      playButtonSound();
                    },
                    child: Image.asset(
                      'assets/poduim.png',
                      fit: BoxFit.cover,
                    ),
                    style: ClassementButton(context).copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, buttonHeight)),
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      playButtonSound();
                    },
                    child: Image.asset(
                      'assets/poduim.png',
                      fit: BoxFit.cover,
                    ),
                    style: ClassementButton(context).copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, buttonHeight)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              playButtonSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DifficultySelectionPage(isPlaying: widget.isPlaying)),
              );
            },
            child: Text('RETOUR'),
            style: SecondaryButton(context),
          ),
        ], false),
      ),
    );
  }
}

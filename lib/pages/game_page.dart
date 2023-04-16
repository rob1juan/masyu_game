import 'package:flutter/material.dart';
import 'package:masyu_game/widgets/game.dart';
import 'package:masyu_game/pages/finish_page.dart';
import 'package:masyu_game/pages/level_selection_page.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Color.dart';
import 'package:masyu_game/widgets/stopwatch_text.dart';

import 'package:just_audio/just_audio.dart';
import 'package:masyu_game/widgets/background_audio.dart';
import 'package:masyu_game/pages/music_preferences.dart';

class GamePage extends StatefulWidget {
  final ValueNotifier<bool> isPlaying;
  final int level;
  final int difficulty;

  GamePage(
      {required this.isPlaying, required this.level, required this.difficulty});
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Duration _elapsedTime = Duration.zero;
  final backgroundPlayer = AudioPlayer();
  final buttonPlayer = AudioPlayer();
  late GameBoard gameBoard;
  int level = 1;

  void startBackgroundMusic(BuildContext context) async {
    final player = BackgroundAudio.of(context).backgroundPlayer;
    final isPlaying = BackgroundAudio.of(context).isPlaying;

    if (isPlaying.value) return;

    await player.setAsset('assets/music/game.mp3');
    player.setLoopMode(LoopMode.one);
    player.play();
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

  void musicStop() {
    final player = BackgroundAudio.of(context).backgroundPlayer;
    player.stop();
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
    gameBoard = GameBoard(level: widget.level, difficulty: widget.difficulty);
    level = widget.level;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startBackgroundMusic(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      BackgroundGradient,
      Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            playButtonSound();
            widget.isPlaying.value = false;
            musicStop();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LevelSelectionPage(
                      isPlaying: widget.isPlaying,
                      difficulty: widget.difficulty)),
            );
          },
        ),
      ),
      Center(child: LayoutBuilder(
        builder: (context, constraints) {
          final double size = constraints.maxWidth < constraints.maxHeight
              ? constraints.maxWidth
              : constraints.maxHeight;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                "Niveau " + level.toString(),
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 30),
              Text(
                "Temps",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              StopwatchText(
                onElapsedChanged: (elapsed) {
                  setState(() {
                    _elapsedTime = elapsed;
                  });
                },
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(40, 255, 255, 255)),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: gameBoard,
                    ),
                  ),
                );
              }
            },
            child: Text("VALIDER"),
            style: SuccessButton(context),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              playButtonSound();
              setState(() {
                gameBoard.plateau!.ResetLines();
                gameBoard.plateau!.CheckValidity();
              });
            },
            child: Text("RECOMMENCER"),
            style: DangerButton(context),
          ),
          SizedBox(height: 20),
        ],
      ))
    ]));
  }
}

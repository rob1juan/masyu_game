import 'package:flutter/material.dart';
import 'package:masyu_game/core/score_board_utils.dart';
import 'package:masyu_game/pages/level_selection_page.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/models/score_board_entry_model.dart';

import 'package:just_audio/just_audio.dart';
import 'package:masyu_game/widgets/background_audio.dart';
import 'package:masyu_game/pages/music_preferences.dart';

class ClassementPage extends StatefulWidget {
  final ValueNotifier<bool> isPlaying;
  final int level;
  final int difficulty;
  final int id;

  ClassementPage(
      {required this.isPlaying,
      required this.level,
      required this.difficulty,
      required this.id});

  @override
  _classement_pageState createState() => _classement_pageState();
}

class _classement_pageState extends State<ClassementPage> {
  List<ScoreBoardEntry> players = List.empty(growable: true);
  int currentRank = 0;

  Future<dynamic> fetchData() async {
    final scores = await getScores(widget.level, widget.difficulty, widget.id);
    setState(() {
      players = scores.scores;
      currentRank = scores.currentRank;
    });
  }

  final backgroundPlayer = AudioPlayer();
  final buttonPlayer = AudioPlayer();

  void startBackgroundMusic(BuildContext context) async {
    final player = BackgroundAudio.of(context).backgroundPlayer;
    final isPlaying = BackgroundAudio.of(context).isPlaying;

    if (isPlaying.value) return;

    await player.setAsset('assets/music/menu.mp3');
    player.setLoopMode(LoopMode.one);
    player.play();
    isPlaying.value = true;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startBackgroundMusic(context);
    });
    fetchData();
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
          SizedBox(height: topSpacing * 0.75),
          const Text(
            "CLASSEMENT",
            style: TextStyle(
                fontSize: 23, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          !players.isEmpty
              ? Container(
                  width: screenWidth * 0.8,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        players.isNotEmpty
                            ? Container(
                                height: verticalSpacing * 15,
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(scrollbars: false),
                                  child: ListView.builder(
                                      itemCount: players
                                          .length, // nombre d'éléments dans la liste
                                      itemBuilder: (context, index) => ScoreRow(
                                          context,
                                          index + 1,
                                          players[index],
                                          index + 1 == currentRank)),
                                ),
                              )
                            : SizedBox(height: verticalSpacing * 15),
                        currentRank != 0 && currentRank > 5
                            ? Divider(
                                color: Colors.white.withOpacity(0.35),
                              )
                            : SizedBox(),
                        SizedBox(height: verticalSpacing * 0.2),
                        widget.id != -1 && currentRank > 5
                            ? ScoreRow(context, currentRank,
                                players[currentRank - 1], true)
                            : SizedBox(),
                      ]),
                )
              : SizedBox(),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              playButtonSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LevelSelectionPage(
                          isPlaying: widget.isPlaying,
                          difficulty: widget.difficulty,
                        )),
              );
            },
            style: SecondaryButton(context),
            child: const Text('RETOUR'),
          ),
        ], false),
      ),
    );
  }

  Widget ScoreRow(
      BuildContext context, int index, ScoreBoardEntry score, bool isActual) {
    double screenHeight = MediaQuery.of(context).size.height;
    double verticalSpacing = screenHeight * 0.025;
    int m = (score.score * 60 ~/ 60).floor();
    int s = (score.score * 60 - m * 60).floor();
    return Column(children: [
      Container(
          height: verticalSpacing * 2.4,
          decoration: BoxDecoration(
            color: isActual
                ? Color(0xFFF19BFF).withOpacity(0.35)
                : Colors.white.withOpacity(0.35),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Text(
                  (index).toString() + ".",
                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  score.name,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight:
                          isActual ? FontWeight.bold : FontWeight.normal),
                  textAlign: TextAlign.center,
                )),
            Expanded(
                flex: 3,
                child: Text(
                  m.toString() + ":" + s.toString(),
                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          ])),
      const SizedBox(
        height: 6,
      ),
    ]);
  }
}

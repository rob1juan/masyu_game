import 'package:flutter/material.dart';
import 'package:masyu_game/pages/level_selection_page.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/models/score_board_entry_model.dart';

import 'package:just_audio/just_audio.dart';
import 'package:masyu_game/widgets/background_audio.dart';

class ClassementPage extends StatefulWidget {
  final ValueNotifier<bool> isPlaying;
  final Duration elapsedTime;
  final int level;

  ClassementPage(
      {required this.isPlaying,
      required this.elapsedTime,
      required this.level});

  @override
  _classement_pageState createState() => _classement_pageState();
}

class _classement_pageState extends State<ClassementPage> {
  int level = 0;
  int? id;
  classement_page(int lvl, {int? id}) {
    this.level = lvl;
    this.id = id ?? -1;
  }

  List<ScoreBoardEntry> players = [
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1),
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1),
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1),
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1),
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1),
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1),
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1),
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1),
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1),
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1),
    ScoreBoardEntry(name: "Mathéo", score: 10.0, level: 1)
  ];

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startBackgroundMusic(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          const Text(
            "CLASSEMENT",
            style: TextStyle(
                fontSize: 23, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 60 * 5,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                      itemCount:
                          players.length - 1, // nombre d'éléments dans la liste
                      itemBuilder: (context, index) =>
                          ScoreRow(context, index, players[index], false)),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.35),
              ),
              const SizedBox(
                height: 6,
              ),
              ScoreRow(context, players.length - 1, players[players.length - 1],
                  true),
            ]),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              playButtonSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LevelSelectionPage(isPlaying: widget.isPlaying)),
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
    return Column(children: [
      Container(
          height: 54,
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
                  (index).toString() + ".", //ICI
                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  score.name, //ICI
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
                  score.score.toString(), //ICI
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

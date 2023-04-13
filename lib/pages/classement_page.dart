import 'package:flutter/material.dart';
import 'package:masyu_game/pages/difficulty_selection_page.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/models/score_board_entry_model.dart';

class classement_page extends StatelessWidget {
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
          Container(
            width: screenWidth * 0.8,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: verticalSpacing * 15,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                      itemCount:
                          players.length - 1, // nombre d'éléments dans la liste
                      itemBuilder: (context, index) =>
                          ScoreRow(context, index + 1, players[index], false)),
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
              Navigator.pop(context);
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

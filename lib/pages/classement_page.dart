import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masyu_game/core/score_board_utils.dart';
import 'package:masyu_game/pages/difficulty_selection_page.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/models/score_board_entry_model.dart';
import 'package:masyu_game/pages/level_selection_page.dart';

class LoadScoreBoardWidget extends StatelessWidget {
  int level = 0;
  int? id;

  LoadScoreBoardWidget(int lvl, {int? id}) {
    this.level = lvl;
    this.id = id ?? -1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return classement_page(snapshot.data, id != -1, level);
        } else if (snapshot.hasError) {
          Fluttertoast.showToast(
              msg: "Impossible de récupérer la classement.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  Future<dynamic> fetchData() async {
    List<ScoreBoardEntry> scores = await getScores(level);
    return scores;
  }
}

class classement_page extends StatelessWidget {
  List<ScoreBoardEntry> scores = [];
  bool isActual = true;
  int level = 11;

  classement_page(List<ScoreBoardEntry> scores, bool isActual, int level) {
    this.scores = scores;
    this.isActual = isActual;
    this.level = level;
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Définir des tailles responsives pour les espacements
    double verticalSpacing = screenHeight * 0.025;
    double topSpacing = screenHeight * 0.05;
    if (scores.isEmpty) {
      return Scaffold(
          body: Stack(
              children: BuildBasicLayout([
        SizedBox(height: topSpacing * 3),
        Container(
          width: screenWidth * 0.8,
          child: const Text(
            "Pas encore de classement dispoinible pour ce niveau, à vous de jouer!",
            style: TextStyle(
                fontSize: 23, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: verticalSpacing * 6),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LevelSelectionPage(int.parse(level.toString()[0]))),
            );
          },
          style: SecondaryButton(context),
          child: const Text('RETOUR'),
        )
      ], false)));
    }
    int nbScores = isActual ? scores.length - 1 : scores.length;
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
                      itemCount: nbScores,
                      itemBuilder: (context, index) =>
                          ScoreRow(context, index + 1, scores[index], false)),
                ),
              ),
            ]),
          ),
          Expanded(
              flex: 9,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: footer(context),
              )),
        ], false),
      ),
    );
  }

  Widget ScoreRow(
      BuildContext context, int index, ScoreBoardEntry score, bool isActual) {
    double screenHeight = MediaQuery.of(context).size.height;
    double verticalSpacing = screenHeight * 0.025;
    int minutes = score.score.floor();
    int seconds = ((score.score - minutes) * 60).floor();
    String stringScore = minutes.toString() + " : " + seconds.toString();
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
                  stringScore,
                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          ])),
      const SizedBox(
        height: 6,
      ),
    ]);
  }

  Widget footer(BuildContext context) {
    if (!isActual) {
      return Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LevelSelectionPage(int.parse(level.toString()[0]))),
              );
            },
            style: SecondaryButton(context),
            child: const Text('RETOUR'),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      );
    }
    return Column(
      children: [
        Divider(
          color: Colors.white.withOpacity(0.35),
        ),
        const SizedBox(
          height: 6,
        ),
        ScoreRow(context, scores.length, scores[scores.length - 1], true),
        const Spacer(
          flex: 1,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LevelSelectionPage(int.parse(level.toString()[0]))),
            );
          },
          style: SecondaryButton(context),
          child: const Text('RETOUR'),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}

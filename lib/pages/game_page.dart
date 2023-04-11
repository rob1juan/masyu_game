import 'package:flutter/material.dart';
import 'package:masyu_game/widgets/game.dart';
import 'package:masyu_game/pages/finish_page.dart';
import 'package:masyu_game/pages/level_selection_page.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/Theme/Color.dart';
import 'package:masyu_game/widgets/stopwatch_text.dart';
import 'dart:async';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Duration _elapsedTime = Duration.zero;

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LevelSelectionPage()),
            );
          },
        ),
      ),
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Niveau ...",
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
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color.fromARGB(40, 255, 255, 255)),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: GameBoard(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FinishPage(
                    elapsedTime: _elapsedTime,
                  ),
                ),
              );
            },
            child: Text("Valider"),
            style: SuccessButton,
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GamePage()),
              );
            },
            child: Text("Recommencer"),
            style: SecondaryButton,
          ),
        ],
      ))
    ]));
  }
}

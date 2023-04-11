import 'package:flutter/material.dart';
import 'package:masyu_game/widgets/game.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/Theme/Color.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      BackgroundGradient,
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
          Text(
            "59:39",
            style: TextStyle(
                color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
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
            onPressed: () {},
            child: Text("Valider"),
            style: SuccessButton,
          ),
          SizedBox(height: 25),
          Text(
            "Recommencer",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ))
    ]));
  }
}

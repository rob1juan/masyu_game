import 'package:flutter/material.dart';
import 'package:masyu_game/class/plateau.dart';
import 'package:masyu_game/class/case.dart';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final int taille = 5;
  late Plateau plateau;

  @override
  void initState() {
    super.initState();
    plateau = Plateau(taille: taille);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: taille * taille,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: taille,
      ),
      itemBuilder: (BuildContext context, int index) {
        int x = index % taille;
        int y = index ~/ taille;
        Case currentCase = plateau.grille[y][x];
        return GestureDetector(
          onTap: () {
            // Implémentez la logique pour gérer les actions de l'utilisateur ici
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: currentCase.estCorrect ? Colors.green : Colors.white,
            ),
            child: Center(
              child: currentCase.cerclePlein
                  ? CircleAvatar(backgroundColor: Colors.black)
                  : currentCase.cercleVide
                      ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : null,
            ),
          ),
        );
      },
    );
  }
}

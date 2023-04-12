import 'package:masyu_game/models/line.dart';

import 'case.dart';
import 'dart:math';

class Plateau {
  int taille;
  late List<List<Case>> grille;
  late List<Line> lines;

  Plateau({required this.taille}) {
    grille = List.generate(taille, (_) => List.generate(taille, (_) => Case()));
    lines = List.empty(growable: true);
    initializeCercles();
  }

  void initializeCercles() {
    Random random = Random();
    int nombreCercles = (taille * taille * 0.2)
        .round(); // 20% des cases contiennent des cercles

    for (int i = 0; i < nombreCercles; i++) {
      int x = random.nextInt(taille);
      int y = random.nextInt(taille);
      bool cerclePlein = random.nextBool();
      grille[y][x].type = cerclePlein ? CaseType.Filled : CaseType.Circle;
    }
  }
}

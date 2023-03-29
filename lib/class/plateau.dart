import 'case.dart';
import 'dart:math';

class Plateau {
  int taille;
  List<List<Case>> grille;

  Plateau({required this.taille})
      : grille =
            List.generate(taille, (_) => List.generate(taille, (_) => Case())) {
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
      grille[y][x].cerclePlein = cerclePlein;
      grille[y][x].cercleVide = !cerclePlein;
    }
  }
}

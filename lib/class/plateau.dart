import 'case.dart';

class Plateau {
  int taille;
  List<List<Case>> grille;

  Plateau({required this.taille})
      : grille =
            List.generate(taille, (_) => List.generate(taille, (_) => Case()));
}

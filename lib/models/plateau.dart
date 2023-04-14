import 'package:masyu_game/models/line.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;
import 'case.dart';
import 'dart:math';
import 'package:collection/collection.dart';

class Plateau {
  int id;
  int difficulty;
  int taille;
  late List<List<Case>> grille;
  late List<Line> lines;
  late bool validPath;

  Plateau(
      {required this.id,
      required this.taille,
      required this.difficulty,
      required this.grille}) {
    lines = List.empty(growable: true);
    validPath = false;
  }

  void ResetLines() {
    lines.clear();
  }

  bool GameIsValide() {
    if (!isPathValid(lines)) {
      return false;
    }
    for (int i = 0; i < taille; i++) {
      for (int j = 0; j < taille; j++) {
        if (!grille[j][i].isValide) {
          return false;
        }
      }
    }
    return true;
  }

  static Future<Plateau?> loadFromJson(int id, int difficulty) async {
    // Charger le JSON depuis les assets
    final jsonStr = await rootBundle.loadString('assets/maps.json');
    final jsonData = json.decode(jsonStr);

    // Trouver la grille correspondante à l'ID et la difficulté
    final grids = jsonData['grids'];
    final gridData = grids.firstWhere(
      (grid) => grid['id'] == id && grid['difficulty'] == difficulty,
      orElse: () => null,
    );
    if (gridData == null) {
      return null;
    }
    final taille = gridData['size'];
    // Créer la grille
    final List<List<Case>> grille = List.generate(
        taille,
        (x) => List.generate(
            taille,
            (y) => Case.coordinate(
                position: Vector2(y.toDouble(), x.toDouble()))));
    List<dynamic> jsonCases = gridData["cases"];
    for (int i = 0; i < jsonCases.length; i++) {
      Map<String, dynamic> jsonCase = jsonCases[i];
      int x = jsonCase["x"];
      int y = jsonCase["y"];
      String type = jsonCase["type"];
      CaseType caseType = type == "filled" ? CaseType.Filled : CaseType.Circle;
      grille[y][x].type =
          caseType; // Mise à jour de la case dans la liste de cases
    }

    return Plateau(
        id: id, taille: taille, difficulty: difficulty, grille: grille);
  }

  void CheckValidity() {
    for (int i = 0; i < taille; i++) {
      for (int j = 0; j < taille; j++) {
        checkCaseValidity(grille[j][i]);
      }
    }
    validPath = isPathValid(lines);
  }

  void checkCaseValidity(Case currentCase) {
    if (currentCase.type == CaseType.None) {
      currentCase.isValide = true;
      return;
    } else if (currentCase.type == CaseType.Filled) {
      currentCase.isValide = CanbeFilled(currentCase);
      return;
    } else {
      currentCase.isValide = CanbeCircle(currentCase);
      return;
    }
  }

  bool CanbeFilled(Case currentCase) {
    List<Line> adjacentLines = findAdjacentLines(currentCase.position);
    if (adjacentLines.isEmpty) {
      return true;
    }
    if (adjacentLines.length == 1) {
      return false;
    }
    Line line1 = adjacentLines[0];
    Line line2 = adjacentLines[1];

    if (!areLinesAligned(line1, line2)) {
      return false;
    }

    List<Line> adjacentLines1 = line1.start == currentCase.position
        ? findAdjacentLines(line1.end)
        : findAdjacentLines(line1.start);
    List<Line> adjacentLines2 = line2.start == currentCase.position
        ? findAdjacentLines(line2.end)
        : findAdjacentLines(line2.start);

    adjacentLines1.remove(line1);
    adjacentLines2.remove(line2);
    //on vérifie qu'il n'y pas de croisements
    if (adjacentLines1.length > 1 || adjacentLines2.length > 1) {
      return false;
    }

    if (!adjacentLines1.isEmpty && !adjacentLines2.isEmpty) {
      if (areLinesPerpendicular(line1, adjacentLines1[0]) ||
          areLinesPerpendicular(line2, adjacentLines2[0])) {
        return true;
      }
    }

    return false;
  }

  bool CanbeCircle(Case currentCase) {
    List<Line> adjacentLines = findAdjacentLines(currentCase.position);

    if (adjacentLines.isEmpty) {
      return true;
    }
    if (adjacentLines.length == 1) {
      return false;
    }
    Line line1 = adjacentLines[0];
    Line line2 = adjacentLines[1];
    if (!areLinesPerpendicular(line1, line2)) {
      return false;
    }

    List<Line> adjacentLines1 = line1.start == currentCase.position
        ? findAdjacentLines(line1.end)
        : findAdjacentLines(line1.start);
    List<Line> adjacentLines2 = line2.start == currentCase.position
        ? findAdjacentLines(line2.end)
        : findAdjacentLines(line2.start);

    adjacentLines1.remove(line1);
    adjacentLines2.remove(line2);
    //on vérifie qu'il n'y pas de croisements
    if (adjacentLines1.length > 1 || adjacentLines2.length > 1) {
      return false;
    }

    if (!adjacentLines1.isEmpty && !adjacentLines2.isEmpty) {
      if (areLinesAligned(line1, adjacentLines1[0]) &&
          areLinesAligned(line2, adjacentLines2[0])) {
        return true;
      }
    }

    return false;
  }

  List<Line> findAdjacentLines(Vector2 coord) {
    List<Line> adjacentLines = [];

    for (Line line in lines) {
      if (line.start == coord || line.end == coord) {
        adjacentLines.add(line);
      }
    }

    return adjacentLines;
  }

  List<Line> findAdjacentLinesInList(Vector2 coord, List<Line> list) {
    List<Line> adjacentLines = [];

    for (Line line in list) {
      if (line.start == coord || line.end == coord) {
        adjacentLines.add(line);
      }
    }

    return adjacentLines;
  }

  bool areLinesPerpendicular(Line line1, Line line2) {
    Vector2 v1 = line1.end - line1.start;
    Vector2 v2 = line2.end - line2.start;
    double dotProduct = v1.x * v2.x + v1.y * v2.y;
    return (dotProduct.abs() < 0.001);
  }

  bool areLinesAligned(Line line1, Line line2) {
    Vector2 vec1 = line1.end - line1.start;
    Vector2 vec2 = line2.end - line2.start;
    double crossProduct = vec1.x * vec2.y - vec1.y * vec2.x;
    return (crossProduct.abs() < 0.001);
  }

  bool isPathValid(List<Line> list) {
    List<Line> remainingLines = List.from(list);
    Line firstLine;
    List<Vector2> visitedCoordinates = [];

    if (remainingLines.isEmpty || remainingLines.length < 2) {
      return false;
    }

    Line currentLine = firstLine = remainingLines.removeAt(0);
    visitedCoordinates.add(currentLine.start);

    while (remainingLines.isNotEmpty) {
      if (findAdjacentLinesInList(currentLine.start, remainingLines).length >
              1 ||
          findAdjacentLinesInList(currentLine.end, remainingLines).length > 1) {
        return false;
      }

      Line? adjacentLine = remainingLines.firstWhereOrNull((line) =>
          (line.start == currentLine.end || line.end == currentLine.end) ||
          (line.start == currentLine.start || line.end == currentLine.start));

      if (adjacentLine == null) {
        return false;
      }

      if (visitedCoordinates.contains(adjacentLine.start) &&
          ((visitedCoordinates.last != adjacentLine.start) &&
              (visitedCoordinates.first != adjacentLine.start))) {
        return false;
      }

      remainingLines.remove(adjacentLine);
      visitedCoordinates.add(adjacentLine.start == currentLine.end
          ? adjacentLine.end
          : adjacentLine.start == currentLine.start
              ? adjacentLine.end
              : adjacentLine.start);
      currentLine = adjacentLine;
    }

    return firstLine.start == visitedCoordinates.last ||
        firstLine.end == visitedCoordinates.last;
  }
}

import 'package:masyu_game/models/line.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:collection/collection.dart';
import 'case.dart';
import 'dart:math';

class Plateau {
  int taille;
  late List<List<Case>> grille;
  late List<Line> lines;
  late bool validPath;

  Plateau({required this.taille}) {
    grille = List.generate(
        taille,
        (x) => List.generate(
            taille,
            (y) => Case.coordinate(
                position: Vector2(y.toDouble(), x.toDouble()))));
    lines = List.empty(growable: true);
    validPath = false;
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

  void CheckValidity() {
    for (int i = 0; i < taille; i++) {
      for (int j = 0; j < taille; j++) {
        checkCaseValidity(grille[j][i]);
      }
    }
    validPath = isPathValid();
  }

  void checkCaseValidity(Case currentCase) {
    if (currentCase.type == CaseType.None) {
      currentCase.isValide = true;
      return;
    }

    List<Line> adjacentLines = findAdjacentLines(currentCase.position);

    if (adjacentLines.isEmpty) {
      currentCase.isValide = true;
      return;
    }

    if (adjacentLines.length == 1) {
      currentCase.isValide = false;
      return;
    }

    if (currentCase.type == CaseType.Circle) {
      Line line1 = adjacentLines[0];
      Line line2 = adjacentLines[1];

      if (!areLinesPerpendicular(line1, line2)) {
        currentCase.isValide = false;
        return;
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
        currentCase.isValide = false;
        return;
      }

      if (!adjacentLines1.isEmpty && !adjacentLines2.isEmpty) {
        if (areLinesAligned(line1, adjacentLines1[0]) ||
            areLinesAligned(line2, adjacentLines2[0])) {
          currentCase.isValide = true;
          return;
        }
      }

      currentCase.isValide = false;
      return;
    }

    if (currentCase.type == CaseType.Filled) {
      Line line1 = adjacentLines[0];
      Line line2 = adjacentLines[1];

      if (!areLinesAligned(line1, line2)) {
        currentCase.isValide = false;
        return;
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
        currentCase.isValide = false;
        return;
      }

      if (!adjacentLines1.isEmpty && !adjacentLines2.isEmpty) {
        if (areLinesPerpendicular(line1, adjacentLines1[0]) ||
            areLinesPerpendicular(line2, adjacentLines2[0])) {
          currentCase.isValide = true;
          return;
        }
      }

      currentCase.isValide = false;
      return;
    }
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
    Vector2 start1 = line1.start;
    Vector2 end1 = line1.end;
    Vector2 start2 = line2.start;
    Vector2 end2 = line2.end;

    double angle1 = atan2(end1.y - start1.y, end1.x - start1.x);
    double angle2 = atan2(end2.y - start2.y, end2.x - start2.x);

    // We calculate the absolute difference of the angles and check if it's equal to 90 degrees
    return ((angle1 - angle2).abs() - pi / 2).abs() < 0.001;
  }

  bool areLinesAligned(Line line1, Line line2) {
    Vector2 start1 = line1.start;
    Vector2 end1 = line1.end;
    Vector2 start2 = line2.start;
    Vector2 end2 = line2.end;

    double angle1 = atan2(end1.y - start1.y, end1.x - start1.x);
    double angle2 = atan2(end2.y - start2.y, end2.x - start2.x);

    // We calculate the absolute difference of the angles and check if it's less than a small number
    return ((angle1 - angle2).abs() < 0.001);
  }

  bool isPathValid() {
    List<Line> remainingLines = List.from(lines);
    Line firstLine;
    List<Vector2> visitedCoordinates = [];

    if (remainingLines.isEmpty) {
      return false;
    }

    Line currentLine = firstLine = remainingLines.removeAt(0);
    visitedCoordinates.add(currentLine.start);

    while (remainingLines.isNotEmpty) {
      Line? adjacentLine = remainingLines.firstWhereOrNull((line) =>
          (line.start == currentLine.end || line.end == currentLine.end) ||
          (line.start == currentLine.start || line.end == currentLine.start));

      if (adjacentLine == null) {
        return false;
      }

      if (visitedCoordinates.contains(adjacentLine.start) &&
          visitedCoordinates.last != adjacentLine.start) {
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

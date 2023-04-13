import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Color.dart';
import 'package:masyu_game/models/plateau.dart';
import 'package:masyu_game/models/case.dart';
import 'package:masyu_game/models/line.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final int taille = 8;
  final GlobalKey _centerKey = GlobalKey();
  late Plateau plateau;

  bool _isDragging = false;
  vector.Vector2? _dragStart;

  @override
  void initState() {
    super.initState();
    plateau = Plateau(taille: taille);
  }

  vector.Vector2? _touchPositionToGrid(Offset touchPosition, double gridSize) {
    int x = (touchPosition.dx / gridSize).floor();
    int y = (touchPosition.dy / gridSize).floor();

    if (x < 0 || x >= taille || y < 0 || y >= taille) {
      return null;
    }
    return vector.Vector2(x.toDouble(), y.toDouble());
  }

  vector.Vector2 correctEndPoint(vector.Vector2 start, vector.Vector2 end) {
    double distance = start.distanceTo(end);

    if (distance > 1) {
      double deltaX = (end.x - start.x) / distance;
      double deltaY = (end.y - start.y) / distance;
      end = vector.Vector2(start.x + deltaX, start.y + deltaY);
    }

    return end;
  }

  bool _isLineDiagonal(vector.Vector2 start, vector.Vector2 end) {
    return start.x != end.x && start.y != end.y;
  }

  int _getLineIndex(vector.Vector2 start, vector.Vector2 end) {
    for (int i = 0; i < plateau.lines.length; i++) {
      if ((plateau.lines[i].start == start && plateau.lines[i].end == end) ||
          (plateau.lines[i].start == end && plateau.lines[i].end == start)) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double gridSize = constraints.maxWidth / taille;
        return GestureDetector(
          onPanDown: (DragDownDetails details) {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            double verticalPadding =
                (constraints.maxHeight - constraints.maxWidth) / 2;
            final touchPosition =
                renderBox.globalToLocal(details.globalPosition) -
                    Offset(0, verticalPadding);
            _dragStart = _touchPositionToGrid(touchPosition, gridSize);
            if (_dragStart != null) {
              _isDragging = true;
            }
          },
          onPanUpdate: (DragUpdateDetails details) {
            if (_isDragging) {
              RenderBox renderBox =
                  _centerKey.currentContext!.findRenderObject() as RenderBox;
              double verticalPadding =
                  (constraints.maxHeight - constraints.maxWidth) / 2;
              final touchPosition =
                  renderBox.globalToLocal(details.globalPosition) -
                      Offset(0, verticalPadding);
              vector.Vector2? currentGridPos =
                  _touchPositionToGrid(touchPosition, gridSize);

              if (currentGridPos != null &&
                  _dragStart != null &&
                  currentGridPos != _dragStart &&
                  !_isLineDiagonal(_dragStart!, currentGridPos)) {
                setState(() {
                  int lineIndex = _getLineIndex(_dragStart!, currentGridPos!);
                  if (lineIndex != -1) {
                    plateau.lines.removeAt(lineIndex);
                    plateau.CheckValidity();
                  } else {
                    currentGridPos =
                        correctEndPoint(_dragStart!, currentGridPos!);
                    plateau.lines
                        .add(Line(start: _dragStart!, end: currentGridPos!));
                    plateau.CheckValidity();
                  }
                  _dragStart = currentGridPos;
                });
              }
            }
          },
          onPanEnd: (DragEndDetails details) {
            if (_isDragging) {
              _isDragging = false;
            }
          },
          child: Center(
            key: _centerKey,
            child: SizedBox(
              height: gridSize * taille,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxWidth),
                    painter: LinePainter(
                        lines: plateau.lines,
                        gridSize: gridSize,
                        isValid: plateau.validPath),
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: taille * taille,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: taille,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      int x = index % taille;
                      int y = index ~/ taille;
                      Case currentCase = plateau.grille[y][x];
                      plateau.checkCaseValidity(currentCase);
                      return GestureDetector(
                        onTap: () {
                          // Implémentez la logique pour gérer les actions de l'utilisateur ici
                        },
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: 8, // ajustez la taille du point ici
                                height: 8, // ajustez la taille du point ici
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                                      .withOpacity(0.2), // réglez l'opacité ici
                                ),
                              ),
                            ),
                            Center(
                              child: currentCase.type == CaseType.Filled
                                  ? CircleAvatar(
                                      backgroundColor: currentCase.isValide
                                          ? Colors.white
                                          : danger)
                                  : currentCase.type == CaseType.Circle
                                      ? Container(
                                          width:
                                              40, // ajustez la taille du cercle ici
                                          height:
                                              40, // ajustez la taille du cercle ici
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                255, 186 - y * 2, 79, 226),
                                            border: Border.all(
                                                color: currentCase.isValide
                                                    ? Colors.white
                                                    : danger,
                                                width: 3),
                                          ),
                                        )
                                      : null,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LinePainter extends CustomPainter {
  final List<Line> lines;
  final double gridSize;
  final bool isValid;

  LinePainter(
      {required this.lines, required this.gridSize, required this.isValid});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < lines.length; i++) {
      final start = Offset(lines[i].start.x * gridSize + gridSize / 2,
          lines[i].start.y * gridSize + gridSize / 2);
      final end = Offset(lines[i].end.x * gridSize + gridSize / 2,
          lines[i].end.y * gridSize + gridSize / 2);
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) {
    return oldDelegate.lines != lines;
  }
}

import 'package:flutter/material.dart';
import 'package:masyu_game/class/plateau.dart';
import 'package:masyu_game/class/case.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:audioplayers/audioplayers.dart';

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
  List<vector.Vector2> lines = [];

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
    return vector.Vector2(x.toDouble(), y.toDouble() + 1);
  }

  bool _isLineDiagonal(vector.Vector2 start, vector.Vector2 end) {
    return start.x != end.x && start.y != end.y;
  }

  int _getLineIndex(vector.Vector2 start, vector.Vector2 end) {
    for (int i = 0; i < lines.length - 1; i += 2) {
      if ((lines[i] == start && lines[i + 1] == end) ||
          (lines[i] == end && lines[i + 1] == start)) {
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
            RenderBox renderBox =
                _centerKey.currentContext!.findRenderObject() as RenderBox;
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
                  int lineIndex = _getLineIndex(_dragStart!, currentGridPos);
                  if (lineIndex != -1) {
                    lines.removeRange(lineIndex, lineIndex + 2);
                  } else {
                    lines.add(_dragStart!);
                    lines.add(currentGridPos);
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
              width: constraints.maxWidth,
              height: constraints.maxWidth + 100,
              child: Stack(
                children: [
                  GridView.builder(
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
                            border: Border.all(
                                color: const Color.fromARGB(0, 0, 0, 0)),
                            color: Color.fromARGB(0, 185, 78,
                                228), // Changez la couleur d'arrière-plan ici
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: currentCase.cerclePlein
                                    ? CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 255, 255))
                                    : currentCase.cercleVide
                                        ? Container(
                                            width:
                                                40, // ajustez la taille du cercle ici
                                            height:
                                                40, // ajustez la taille du cercle ici
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color.fromARGB(
                                                  0, 255, 255, 255),
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  width: 3),
                                            ),
                                          )
                                        : null,
                              ),
                              Center(
                                child: Container(
                                  width: 8, // ajustez la taille du point ici
                                  height: 8, // ajustez la taille du point ici
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(
                                        0.2), // réglez l'opacité ici
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: LinePainter(lines: lines, gridSize: gridSize),
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
  final List<vector.Vector2> lines;
  final double gridSize;

  LinePainter({required this.lines, required this.gridSize});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < lines.length - 1; i += 2) {
      final start = Offset(lines[i].x * gridSize + gridSize / 2,
          lines[i].y * gridSize + gridSize / 4);
      final end = Offset(lines[i + 1].x * gridSize + gridSize / 2,
          lines[i + 1].y * gridSize + gridSize / 4);
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) {
    return oldDelegate.lines != lines;
  }
}

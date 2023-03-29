import 'package:flutter/material.dart';
import 'package:masyu_game/class/plateau.dart';
import 'package:masyu_game/class/case.dart';
import 'package:flutter/gestures.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final int taille = 8;
  late Plateau plateau;

  bool _isDragging = false;
  vector.Vector2? _dragStart;
  List<vector.Vector2> lines = [];

  @override
  void initState() {
    super.initState();
    plateau = Plateau(taille: taille);
  }

  vector.Vector2 _touchPositionToGrid(Offset touchPosition, double gridSize) {
    int x = (touchPosition.dx / gridSize).floor();
    int y = (touchPosition.dy / gridSize).floor();
    return vector.Vector2(x.toDouble(), y.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double gridSize = constraints.maxWidth / taille;
        return GestureDetector(
          onPanDown: (DragDownDetails details) {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            final touchPosition =
                renderBox.globalToLocal(details.globalPosition);
            _dragStart = _touchPositionToGrid(touchPosition, gridSize);
            _isDragging = true;
          },
          onPanUpdate: (DragUpdateDetails details) {
            if (_isDragging) {
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              final touchPosition =
                  renderBox.globalToLocal(details.globalPosition);
              vector.Vector2 currentGridPos =
                  _touchPositionToGrid(touchPosition, gridSize);

              if (currentGridPos != _dragStart) {
                setState(() {
                  lines.add(_dragStart!);
                  lines.add(currentGridPos);
                  _dragStart = currentGridPos;
                });
              }
            }
          },
          onPanEnd: (DragEndDetails details) {
            _isDragging = false;
          },
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
                        border: Border.all(color: Colors.black),
                        color: currentCase.estCorrect
                            ? Colors.green
                            : Colors.white,
                      ),
                      child: Center(
                        child: currentCase.cerclePlein
                            ? CircleAvatar(backgroundColor: Colors.black)
                            : currentCase.cercleVide
                                ? Container(
                                    width:
                                        40, // ajustez la taille du cercle ici
                                    height:
                                        40, // ajustez la taille du cercle ici
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 3),
                                    ),
                                  )
                                : null,
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
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < lines.length - 1; i += 2) {
      final start = Offset(lines[i].x * gridSize + gridSize / 2,
          lines[i].y * gridSize + gridSize / 2);
      final end = Offset(lines[i + 1].x * gridSize + gridSize / 2,
          lines[i + 1].y * gridSize + gridSize / 2);
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) {
    return true;
  }
}

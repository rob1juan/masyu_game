import 'package:vector_math/vector_math_64.dart';

class Case {
  CaseType type;
  bool isValide;
  late Vector2 position;

  Case({
    this.type = CaseType.None,
    this.isValide = false,
  });

  Case.coordinate({
    required this.position,
    this.type = CaseType.None,
    this.isValide = false,
  });
}

enum CaseType { None, Filled, Circle }

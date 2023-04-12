class Case {
  CaseType type;
  bool isValide;

  Case({
    this.type = CaseType.None,
    this.isValide = false,
  });
}

enum CaseType { None, Filled, Circle }

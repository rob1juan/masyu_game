class ScoreBoardEntry {
  final String name;
  final double score;
  final int level;
  final int difficulty;

  const ScoreBoardEntry(
      {required this.name,
      required this.score,
      required this.level,
      required this.difficulty});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'level': level,
      'difficulty': difficulty
    };
  }

  @override
  String toString() {
    return 'Score{name: $name, score: $score, level: $level, difficulty: $difficulty}';
  }
}

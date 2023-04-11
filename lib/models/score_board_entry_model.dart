class ScoreBoardEntry {
  final String name;
  final double score;
  final int level;

  const ScoreBoardEntry({
    required this.name,
    required this.score,
    required this.level
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'level': level
    };
  }

  @override
  String toString() {
    return 'Score{name: $name, score: $score, level: $level}';
  }

}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:masyu_game/pages/level_selection_page.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/score_board_entry_model.dart';

Future<List<ScoreBoardEntry>> getScores(int level) async {
  final db = await openDatabase(
    join(await getDatabasesPath(), 'score_board.db'),
  );

  final List<Map<String, dynamic>> maps = await db.query(
    'score',
    where: 'level = ?',
    whereArgs: [level],
    orderBy: 'score'
  );

  return List.generate(maps.length, (i) {
    return ScoreBoardEntry(
      name: maps[i]['name'],
      score: maps[i]['score'],
      level: maps[i]['level']
    );
  });
}

Future<int> saveScore(ScoreBoardEntry score) async {
  final db = await openDatabase(
    join(await getDatabasesPath(), 'score_board.db'),
  );

  int id = await db.insert(
    'score',
    score.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return id;
}
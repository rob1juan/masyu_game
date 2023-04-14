import 'dart:math';

import 'package:flutter/material.dart';
import 'package:masyu_game/pages/level_selection_page.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/score_board_entry_model.dart';

Future<List<ScoreBoardEntry>> getScores(int level, int difficulty) async {
  var databaseFactory = databaseFactoryFfi;
  final dbPath =
      '/data/user/0/com.example.masyu_game/app_flutter/score_board.db';

  final db = await databaseFactory.openDatabase(dbPath);

  final List<Map<String, dynamic>> maps = await db.query('score',
      where: 'level = ? AND difficulty = ?',
      whereArgs: [level, difficulty],
      orderBy: 'score');

  await db.close();
  return List.generate(maps.length, (i) {
    return ScoreBoardEntry(
        name: maps[i]['name'],
        score: maps[i]['score'],
        level: maps[i]['level'],
        difficulty: maps[i]['difficulty']);
  });
}

Future<int> saveScore(ScoreBoardEntry score) async {
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;

  final dbPath =
      '/data/user/0/com.example.masyu_game/app_flutter/score_board.db';

  final db = await databaseFactory.openDatabase(dbPath);
  int id = await db.insert(
    'score',
    score.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  await db.close();

  return id;
}

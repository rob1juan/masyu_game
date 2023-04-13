import 'package:flutter/material.dart';
import 'package:masyu_game/pages/menu_page.dart';
import 'package:masyu_game/Theme/Color.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:just_audio/just_audio.dart';
import 'package:masyu_game/widgets/background_audio.dart';

void main() async {
  // init the db
  sqfliteFfiInit();
  final dbPath =
      '/data/user/0/com.example.masyu_game/app_flutter/score_board.db';
  var databaseFactory = databaseFactoryFfi;
  final db = await databaseFactory.openDatabase(dbPath);
  await db.execute(
      'CREATE TABLE IF NOT EXISTS score(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, score REAL, level INTEGER)');
  await db.close();

  runApp(MasyuApp());
}

class MasyuApp extends StatelessWidget {
  final backgroundPlayer = AudioPlayer();
  final isPlaying = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BackgroundAudio(
      backgroundPlayer: backgroundPlayer,
      isPlaying: isPlaying,
      child: MaterialApp(
        title: 'Masyu Game',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MenuPage(isPlaying: isPlaying),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

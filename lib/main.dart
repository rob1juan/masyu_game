import 'package:flutter/material.dart';
import 'package:masyu_game/pages/menu_page.dart';
import 'package:masyu_game/Theme/Color.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final database = await openDatabase(
  //   // Set the path to the database. Note: Using the `join` function from the
  //   // `path` package is best practice to ensure the path is correctly
  //   // constructed for each platform.
  //   join(await getDatabasesPath(), 'score_board.db'),
  //   onCreate: (db, version) {
  //     // Run the CREATE TABLE statement on the database.
  //     return db.execute(
  //       'CREATE TABLE score(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, score REAL, level INTEGER)',
  //     );
  //   },
  //   // Set the version. This executes the onCreate function and provides a
  //   // path to perform database upgrades and downgrades.
  //   version: 1,
  // );
  runApp(MasyuApp());
}

class MasyuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masyu',
      home: MenuPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

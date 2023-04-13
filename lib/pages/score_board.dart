import 'dart:math';

import 'package:flutter/material.dart';
import 'package:masyu_game/pages/level_selection_page.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../core/score_board_utils.dart';
import '../models/score_board_entry_model.dart';

class CassementPage extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CassementPage> {
  String _displayText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classement'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _displayText,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Enregistrer le score'),
              onPressed: () async {
                double score = Random().nextDouble() * 100;
                ScoreBoardEntry s =
                    ScoreBoardEntry(name: 'Fido', score: score, level: 11);
                var text = await saveScore(s).toString();
                setState(() {
                  _displayText = text;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}

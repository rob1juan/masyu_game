import 'package:flutter/material.dart';
import 'package:masyu_game/pages/menu_page.dart';
import 'package:masyu_game/Theme/Color.dart';

void main() {
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

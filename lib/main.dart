import 'package:flutter/material.dart';
import 'package:masyu_game/pages/menu_page.dart';

void main() {
  runApp(MasyuApp());
}

class MasyuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masyu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

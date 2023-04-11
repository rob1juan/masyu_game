import 'package:flutter/material.dart';
import 'package:masyu_game/pages/level_selection_page.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';

class DifficultySelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LevelSelectionPage()),
              );
            },
            child: Text('FACILE'),
            style: SuccessButton,
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LevelSelectionPage()),
              );
            },
            child: Text('MOYEN'),
            style: WarningButton,
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LevelSelectionPage()),
              );
            },
            child: Text('DIFFICILE'),
            style: DangerButton,
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('RETOUR'),
            style: SecondaryButton,
          ),
          SizedBox(height: 100),
        ], false),
      ),
    );
  }
}

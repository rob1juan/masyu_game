import 'package:flutter/material.dart';
import 'package:masyu_game/pages/difficulty_selection_page.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DifficultySelectionPage()),
              );
            },
            child: Text('JOUER'),
            style: YellowButton,
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // TODO: Implémenter la navigation vers la page des options
            },
            child: Text('OPTIONS'),
            style: WarningButton,
          ),
        ], true),
      ),
    );
  }
}

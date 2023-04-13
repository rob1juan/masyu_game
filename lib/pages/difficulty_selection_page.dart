import 'package:flutter/material.dart';
import 'package:masyu_game/pages/level_selection_page.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/pages/menu_page.dart';

class DifficultySelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Définir des tailles responsives pour les espacements
    double verticalSpacing = screenHeight * 0.025;
    double topSpacing = screenHeight * 0.05;

    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          SizedBox(height: topSpacing * 1.5),
          Text(
            'DIFFICULTE',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: verticalSpacing * 2),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LevelSelectionPage(1)),
              );
            },
            child: Text('FACILE'),
            style: SuccessButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LevelSelectionPage(2)),
              );
            },
            child: Text('MOYEN'),
            style: WarningButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LevelSelectionPage(3)),
              );
            },
            child: Text('DIFFICILE'),
            style: DangerButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
            child: Text('RETOUR'),
            style: SecondaryButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
        ], false),
      ),
    );
  }
}

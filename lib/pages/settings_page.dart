import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';

class SettingsPage extends StatelessWidget {
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
          SizedBox(height: topSpacing * 2),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('MUSIQUE'),
            style: YellowButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('REGLES'),
            style: WarningButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('A PROPOS'),
            style: PrimaryButton(context),
          ),
          SizedBox(height: verticalSpacing * 1.5),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
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

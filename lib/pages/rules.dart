import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/pages/settings_page.dart';

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Définir des tailles responsives pour les espacements
    double verticalSpacing = screenHeight * 0.025;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFBE2EDD),
                  Color(0xFF902EDD),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Stack(
              children: BuildFinishLayout([
                SizedBox(height: screenHeight * 0.03),
                const Text('LES REGLES',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 25)),
                SizedBox(height: screenHeight * 0.1),
                Container(
                  width: screenWidth * 0.7,
                  child: const Text(
                      'Il faut dessiner des lignes entre les points pour former une boucle unique sans croisement.\n\n\nLa boucle doit passer à travers tous les cercles blancs et noirs de la façon suivante :\n\n- On doit passer à travers les cercles blancs en ligne droite, mais la boucle doit tourner dans la cellule précédente et/ou suivante.\n\n- La boucle doit tourner sur les cercles noirs et aller tout droit dans la cellule précédente et la cellule suivante.\n\n\nGlisser votre doigt entre les points pour les relier, et repasser dessus pour les supprimer.',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                      textAlign: TextAlign.justify),
                ),
                SizedBox(height: screenHeight * 0.05),
                // Insère un gif
                Image.asset(
                  'assets/Cat2.gif',
                  fit: BoxFit.contain,
                  height: 125,
                ),
              ]),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

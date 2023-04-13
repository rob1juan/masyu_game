import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/pages/settings_page.dart';

class AboutPage extends StatelessWidget {
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
                const Text('A PROPOS',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 25)),
                SizedBox(height: screenHeight * 0.1),
                Container(
                  width: screenWidth * 0.7,
                  child: const Text(
                      'Bienvenue dans le monde merveilleux d\'ARMM !\n\nNotre petite équipe de joyeux lurons est composée d\'Aurélien, Mathéo, Maxime et Robin, tous armés d\'une passion débordante pour les jeux sur smartphone. Et notre dernier bébé, c\'est un jeu de Masyu qui va vous faire tourner la tête (mais dans le bon sens du terme, promis). \n\nAlors, si vous êtes prêt à rejoindre la bande d\'ARMM et à vous amuser comme jamais, téléchargez notre jeu de Masyu et préparez-vous à passer des heures (voire des jours, voire des semaines) à jouer !',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                      textAlign: TextAlign.justify),
                ),
                SizedBox(height: screenHeight * 0.07),
                // Insère un gif
                Image.asset(
                  'assets/Cat.gif',
                  fit: BoxFit.contain,
                  height: 100,
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

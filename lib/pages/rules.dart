import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/pages/settings_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Créer le carrousel slider
    final carouselSlider = CarouselSlider(
      options: CarouselOptions(height: screenHeight * 0.7, autoPlay: false),
      items: [
        // Première slide
        Container(
          width: screenWidth * 0.7,
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1),
              Text(
                "Le Masyu est un jeu de logique japonais qui se joue sur une grille. \n\nLe but du jeu est de tracer un chemin continu à travers les cercles blancs et noirs présents sur la grille, en respectant certaines règles. \n\nVoici les règles de base pour résoudre une grille de Masyu...",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        // Deuxième slide
        Container(
          width: screenWidth * 0.7,
          child: Column(
            children: [
              Text(
                "Le chemin doit passer par tous les cercles, blancs et noirs, sans exception.",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: screenHeight * 0.05),
              Image.asset(
                'assets/puzzle-masyu.png',
                fit: BoxFit.contain,
                height: 250,
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                "Le chemin ne doit jamais se croiser ni se superposer.",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        // Troisième slide
        Container(
          width: screenWidth * 0.7,
          child: Column(
            children: [
              Text(
                "Lorsque le chemin passe par un cercle blanc :\na. Il doit continuer tout droit et ne pas tourner à angle droit.\nb. Il doit tourner à angle droit au moins une fois soit avant, soit après le cercle blanc, ou les deux.",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              // Image
              Image.asset(
                'assets/regle-b-vrai.png',
                fit: BoxFit.contain,
                height: 150,
              ),
              Image.asset(
                'assets/regle-b-faux.png',
                fit: BoxFit.contain,
                height: 150,
              ),
            ],
          ),
        ),
        // Quatrième slide
        Container(
          width: screenWidth * 0.7,
          child: Column(
            children: [
              Text(
                "Lorsque le chemin passe par un cercle noir :\na. Il doit obligatoirement tourner à angle droit.\nb. Il doit continuer tout droit sur au moins une case de chaque côté du cercle noir.",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: screenHeight * 0.05),
              // Image
              Image.asset(
                'assets/regle-n-vrai.png',
                fit: BoxFit.contain,
                height: 170,
              ),
              SizedBox(height: screenHeight * 0.05),
              Image.asset(
                'assets/regle-n-faux.png',
                fit: BoxFit.contain,
                height: 170,
              ),
            ],
          ),
        ),
        // Cinquième slide
        Container(
          width: screenWidth * 0.7,
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1),
              Text(
                "ENJOY !",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 30),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: screenHeight * 0.05),
              // Insère un gif
              Image.asset(
                'assets/Cat2.gif',
                fit: BoxFit.contain,
                height: 125,
              ),
            ],
          ),
        ),
      ],
    );

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
                carouselSlider, // Ajouter le carrousel slider
                SizedBox(height: screenHeight * 0.05),
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

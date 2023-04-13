import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/pages/settings_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:just_audio/just_audio.dart';
import 'package:masyu_game/widgets/background_audio.dart';

class RulesPage extends StatefulWidget {
  final ValueNotifier<bool> isPlaying;

  RulesPage({required this.isPlaying});
  @override
  _RulesPageState createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  final backgroundPlayer = AudioPlayer();
  final buttonPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    startBackgroundMusic();
  }

  void startBackgroundMusic() async {
    final player = BackgroundAudio.of(context).backgroundPlayer;
    final isPlaying = BackgroundAudio.of(context).isPlaying;

    if (isPlaying.value) return;

    await player.setAsset('assets/music/menu.mp3');
    player.setLoopMode(LoopMode.one);
    player.play();
    isPlaying.value = true;
  }

  void playButtonSound() {
    buttonPlayer.setAsset('assets/music/pop.mp3').then((_) {
      buttonPlayer.play();
    });
  }

  @override
  void dispose() {
    backgroundPlayer.dispose();
    buttonPlayer.dispose();
    super.dispose();
  }

  // Permet de savoir sur quelle slide on se trouve
  int _currentPage = 0;
  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Créer le carrousel slider
    final carouselSlider = CarouselSlider(
      carouselController: _carouselController,
      options: CarouselOptions(
        height: screenHeight * 0.7,
        viewportFraction: 1,
        autoPlay: false,
        onPageChanged: (index, reason) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
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
                height: 130,
              ),
              SizedBox(height: screenHeight * 0.05),
              Image.asset(
                'assets/regle-n-faux.png',
                fit: BoxFit.contain,
                height: 130,
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
                buildPageIndicators(
                    carouselSlider.items?.length ?? 0, _currentPage),
              ]),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                playButtonSound();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SettingsPage(isPlaying: widget.isPlaying)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicators(int numPages, int currentPage) {
    List<Widget> indicators = [];

    for (int i = 0; i < numPages; i++) {
      indicators.add(
        Container(
          width: i == currentPage ? 12.0 : 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                i == currentPage ? Colors.white : Colors.white.withOpacity(0.4),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }
}

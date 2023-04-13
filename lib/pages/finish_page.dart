import 'package:flutter/material.dart';
import 'package:masyu_game/pages/level_selection_page.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:clipboard/clipboard.dart';

import 'package:just_audio/just_audio.dart';
import 'package:masyu_game/widgets/background_audio.dart';
import 'package:masyu_game/pages/music_preferences.dart';

class FinishPage extends StatefulWidget {
  final ValueNotifier<bool> isPlaying;
  final Duration elapsedTime;

  FinishPage({required this.isPlaying, required this.elapsedTime});

  @override
  _FinishPageState createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  final TextEditingController _textController = TextEditingController();

  final backgroundPlayer = AudioPlayer();
  final buttonPlayer = AudioPlayer();
  final finishPlayer = AudioPlayer();

  void startBackgroundMusic(AudioPlayer player) async {
    player.setLoopMode(LoopMode.one);
    player.play();
  }

  void playButtonSound() async {
    // Get the stored sound value and soundIsActivated state using MusicPreferences
    double soundValue = await MusicPreferences.getSoundValue();
    bool soundIsActivated = await MusicPreferences.getSoundIsActivated();

    if (soundIsActivated) {
      buttonPlayer.setVolume(soundValue / 100);
    } else {
      buttonPlayer.setVolume(0);
    }

    buttonPlayer.setAsset('assets/music/pop.mp3').then((_) {
      buttonPlayer.play();
    });
  }

  Future<void> finishBackgroundMusic() async {
    await finishPlayer.setAsset('assets/music/finish.mp3');
    await finishPlayer.play();
    final player = BackgroundAudio.of(context).backgroundPlayer;
    final isPlaying = BackgroundAudio.of(context).isPlaying;

    if (isPlaying.value) return;

    await player.setAsset('assets/music/menu.mp3');
    finishPlayer.processingStateStream.listen((event) {
      if (event == ProcessingState.completed) {
        startBackgroundMusic(player);
      }
    });
  }

  @override
  void dispose() {
    backgroundPlayer.dispose();
    buttonPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await finishBackgroundMusic();
    });
  }

  void _shareScore(BuildContext context) {
    String playerName = _textController.text;

    if (playerName.isEmpty) {
      Fluttertoast.showToast(
          msg: "Vous ne pouvez pas partager le score sans nom de joueur.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      String message =
          "Salut ! Voici le nouveau score que je viens de faire sur Masyu :\n"
          "Difficulté : Moyen\n"
          "Niveau : 1\n"
          "Temps : ${widget.elapsedTime.inMinutes.toString().padLeft(2, '0')}:${(widget.elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}\n"
          "Joueur : $playerName\n"
          "Essaye de me battre ! ;))";
      FlutterClipboard.copy(message).then((value) => Fluttertoast.showToast(
          msg: "Message copié dans le presse-papier avec succès!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0));
    }
  }

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
                const Text('NIVEAU TERMINE !',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 25)),
                SizedBox(height: screenHeight * 0.1),
                const Text('Temps',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 60)),
                const SizedBox(height: 30),
                Text(
                  "${widget.elapsedTime.inMinutes.toString().padLeft(2, '0')}:${(widget.elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 60,
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                const Text('Nom du joueur :',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                const SizedBox(height: 10),
                Container(
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color.fromRGBO(255, 255, 255, 0.137),
                  ),
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    autofocus: false,
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                ElevatedButton(
                  onPressed: () => _shareScore(context),
                  child: const Text('PARTAGER'),
                  style: ShareButton(context),
                ),
                SizedBox(height: screenHeight * 0.1),
                ElevatedButton(
                  onPressed: () {
                    playButtonSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LevelSelectionPage(isPlaying: widget.isPlaying)),
                    );
                  },
                  child: const Text('VALIDER'),
                  style: SuccessButton(context),
                ),
                SizedBox(height: screenHeight * 0.1),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

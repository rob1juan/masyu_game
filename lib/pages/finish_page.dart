import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:clipboard/clipboard.dart';

class FinishPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

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
          "Temps : 2min\n"
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
                const Text('00:00',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 60)),
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
                  onPressed: () {},
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

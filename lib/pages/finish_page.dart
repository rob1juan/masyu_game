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
          "Difficulté: Moyen\nGrille: 2\nTemps: 2min24\nEssaye de me battre ;)";
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
                const SizedBox(height: 70),
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
                const SizedBox(height: 75),
                const Text('Nom du joueur :',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                const SizedBox(height: 10),
                Container(
                  width: 250,
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _shareScore(context),
                  child: const Text('PARTAGER'),
                  style: ShareButton,
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('VALIDER'),
                  style: SuccessButton,
                ),
                const SizedBox(height: 70),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

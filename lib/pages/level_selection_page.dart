import 'package:flutter/material.dart';
import 'package:masyu_game/pages/finish_page.dart';
import 'package:masyu_game/pages/game_page.dart';
import 'package:masyu_game/pages/difficulty_selection_page.dart';
import 'package:masyu_game/widgets/game.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/pages/classement_page.dart';

class LevelSelectionPage extends StatelessWidget {
  int difficulty = 1;

  LevelSelectionPage(int difficulty) {
    this.difficulty = difficulty;
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Définir des tailles responsives pour les espacements
    double verticalSpacing = screenHeight * 0.01;
    double horizontalSpacing = screenWidth * 0.025;
    double topSpacing = screenHeight * 0.05;

    double buttonWidth = screenWidth * 0.3;
    double buttonHeight = screenHeight * 0.075;

    String title = "";
    if(difficulty == 1){
      title = "FACILE";
    }else if(difficulty == 2){
      title = "MOYEN";
    }else{
      title = "DIFFICILE";
    }
    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          SizedBox(height: topSpacing * 1.5),
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: topSpacing),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => GamePage()),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinishPage(
                            elapsedTime: Duration(minutes: 0, seconds: 27),
                            level: int.parse(difficulty.toString() + '1'),
                          ),
                        ),
                      );
                    },
                    child: Text('NIVEAU 1'),
                    style: PrimaryButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinishPage(
                            elapsedTime: Duration(minutes: 1, seconds: 27),
                            level: int.parse(difficulty.toString() + '2'),
                          ),
                        ),
                      );
                    },
                    child: Text('NIVEAU 2'),
                    style: PrimaryButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinishPage(
                            elapsedTime: Duration(minutes: 1, seconds: 27),
                            level: int.parse(difficulty.toString() + '3'),
                          ),
                        ),
                      );
                    },
                    child: Text('NIVEAU 3'),
                    style: PrimaryButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinishPage(
                            elapsedTime: Duration(minutes: 1, seconds: 27),
                            level: int.parse(difficulty.toString() + '4'),
                          ),
                        ),
                      );
                    },
                    child: Text('NIVEAU 4'),
                    style: PrimaryButton(context),
                  ),
                ],
              ),
              SizedBox(width: horizontalSpacing),
              Column(
                children: [
                  SizedBox(height: topSpacing),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadScoreBoardWidget(
                                  int.parse(difficulty.toString() + '1'))));
                    },
                    child: Image.asset(
                      'assets/poduim.png',
                      fit: BoxFit.cover,
                    ),
                    style: ClassementButton(context).copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, buttonHeight)),
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadScoreBoardWidget(
                                  int.parse(difficulty.toString() + '2'))));
                    },
                    child: Image.asset(
                      'assets/poduim.png',
                      fit: BoxFit.cover,
                    ),
                    style: ClassementButton(context).copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, buttonHeight)),
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadScoreBoardWidget(
                                  int.parse(difficulty.toString() + '3'))));
                    },
                    child: Image.asset(
                      'assets/poduim.png',
                      fit: BoxFit.cover,
                    ),
                    style: ClassementButton(context).copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, buttonHeight)),
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadScoreBoardWidget(
                                  int.parse(difficulty.toString() + '4'))));
                    },
                    child: Image.asset(
                      'assets/poduim.png',
                      fit: BoxFit.cover,
                    ),
                    style: ClassementButton(context).copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, buttonHeight)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DifficultySelectionPage()),
              );
            },
            child: Text('RETOUR'),
            style: SecondaryButton(context),
          ),
        ], false),
      ),
    );
  }
}

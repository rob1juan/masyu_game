import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';

class LevelSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Définir des tailles responsives pour les espacements
    double verticalSpacing = screenHeight * 0.01;
    double horizontalSpacing = screenWidth * 0.025;
    double topSpacing = screenHeight * 0.05;

    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          SizedBox(height: topSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('NIVEAU 1'),
                    style: PrimaryButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('NIVEAU 2'),
                    style: PrimaryButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('NIVEAU 3'),
                    style: PrimaryButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('NIVEAU 4'),
                    style: PrimaryButton(context),
                  ),
                ],
              ),
              SizedBox(width: horizontalSpacing),
              Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset('assets/poduim.png'),
                    style: ClassementButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset('assets/poduim.png'),
                    style: ClassementButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset('assets/poduim.png'),
                    style: ClassementButton(context),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset('assets/poduim.png'),
                    style: ClassementButton(context),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('RETOUR'),
            style: SecondaryButton(context),
          ),
          SizedBox(height: screenHeight * 0.1),
        ], false),
      ),
    );
  }
}

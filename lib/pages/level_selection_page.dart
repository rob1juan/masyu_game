import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/pages/classement_page.dart';


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

    double buttonWidth = screenWidth * 0.3;
    double buttonHeight = screenHeight * 0.075;

    double imageWidth = screenWidth * 0.13;
    double imageHeight = imageWidth;

    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: topSpacing * 2),
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
                  SizedBox(height: topSpacing * 2),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset(
                      'assets/poduim.png',
                      width: imageWidth,
                      height: imageHeight,
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
                              builder: (context) => classement_page(1, id: 3)),
                        );
                    },
                    child: Image.asset(
                      'assets/poduim.png',
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                    style: ClassementButton(context).copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, buttonHeight)),
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset(
                      'assets/poduim.png',
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                    style: ClassementButton(context).copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, buttonHeight)),
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset(
                      'assets/poduim.png',
                      width: imageWidth,
                      height: imageHeight,
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
              Navigator.pop(context);
            },
            child: Text('RETOUR'),
            style: SecondaryButton(context),
          ),
        ], false),
      ),
    );
  }
}

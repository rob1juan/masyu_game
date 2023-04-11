import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Buttons.dart';
import 'package:masyu_game/Theme/Layout.dart';

class LevelSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('NIVEAU 1'),
                    style: PrimaryButton,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('NIVEAU 2'),
                    style: PrimaryButton,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('NIVEAU 3'),
                    style: PrimaryButton,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('NIVEAU 4'),
                    style: PrimaryButton,
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset('assets/poduim.png'),
                    style: ClassementButton,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset('assets/poduim.png'),
                    style: ClassementButton,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset('assets/poduim.png'),
                    style: ClassementButton,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset('assets/poduim.png'),
                    style: ClassementButton,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('RETOUR'),
            style: SecondaryButton,
          ),
          SizedBox(height: 100),
        ], false),
      ),
    );
  }
}

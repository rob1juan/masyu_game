import 'package:flutter/material.dart';

class LevelSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 40),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choix du niveau'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implémenter la navigation vers le niveau 1
                      },
                      child: Text('Niveau 1'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implémenter la navigation vers le niveau 2
                      },
                      child: Text('Niveau 2'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implémenter la navigation vers le classement du niveau 1
                      },
                      child: Text('Classement'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implémenter la navigation vers le classement du niveau 2
                      },
                      child: Text('Classement'),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implémenter la navigation vers le niveau 3
                      },
                      child: Text('Niveau 3'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implémenter la navigation vers le niveau 4
                      },
                      child: Text('Niveau 4'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implémenter la navigation vers le classement du niveau 3
                      },
                      child: Text('Classement'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implémenter la navigation vers le classement du niveau 4
                      },
                      child: Text('Classement'),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:masyu_game/pages/level_selection_page.dart';

class DifficultySelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(100, 144, 46, 221),
                  Color.fromARGB(100, 190, 46, 221),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300, // Définir la hauteur souhaitée ici
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LevelSelectionPage()),
                          );
                        },
                        child: Text('FACILE'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 86, 240, 43),
                          minimumSize: Size(228, 66),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Colors.black,
                          elevation: 10.0,
                          textStyle: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LevelSelectionPage()),
                          );
                        },
                        child: Text('MOYEN'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 240, 147, 43),
                          minimumSize: Size(228, 66),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Colors.black,
                          elevation: 10.0,
                          textStyle: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LevelSelectionPage()),
                          );
                        },
                        child: Text('DIFFICILE'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 0, 0),
                          minimumSize: Size(228, 66),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Colors.black,
                          elevation: 10.0,
                          textStyle: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('RETOUR'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 232, 30),
                          minimumSize: Size(228, 66),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Colors.black,
                          elevation: 10.0,
                          textStyle: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

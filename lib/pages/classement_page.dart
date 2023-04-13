import 'package:flutter/material.dart';
import 'package:masyu_game/pages/difficulty_selection_page.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/Theme/Buttons.dart';

class classement_page extends StatelessWidget {
  int level = 0;
  int? id;
  classement_page(int lvl, {int? id}) {
    this.level = lvl;
    this.id = id ?? -1;
  }

  List<String> players = [
    "p1",
    "p2",
    "p3",
    "p4",
    "p5",
    "p6",
    "p7",
    "p8",
    "p9",
    "p10",
    "p11",
    "p12",
    "p13",
    "p14",
    "p15",
    "p16",
    "p17",
    "p18",
    "p19",
    "p20",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          const Text(
            "CLASSEMENT",
            style: TextStyle(
                fontSize: 23, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            height: 227,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                  itemCount: players.length, // nombre d'éléments dans la liste
                  itemBuilder: (context, index) => Column(children: [
                        Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    players[index], //ICI
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    "Mathéo", //ICI
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    "59:30", //ICI
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                            ])),
                        const SizedBox(
                          height: 10,
                        ),
                      ])),
            ),
          ),
          Expanded(
              flex: 9,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: footer(context),
              )),
        ], false),
      ),
    );
  }

  Widget footer(BuildContext context) {
    if (id == -1) {
      return Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: SecondaryButton(context),
            child: const Text('RETOUR'),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      );
    }
    return Column(
      children: [
        const Divider(
          color: Colors.white,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 200, 9, 222).withOpacity(0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            SizedBox(
              width: 16,
            ),
            Expanded(
                flex: 2,
                child: Text(
                  "id.", //ICI
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  "Mathéo", //ICI
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            Expanded(
                flex: 3,
                child: Text(
                  "59:30", //ICI
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              width: 16,
            ),
          ]),
        ),
        const Spacer(
          flex: 1,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: SecondaryButton(context),
          child: const Text('RETOUR'),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}

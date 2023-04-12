import 'package:flutter/material.dart';
import 'package:masyu_game/pages/difficulty_selection_page.dart';
import 'package:masyu_game/Theme/Layout.dart';
import 'package:masyu_game/Theme/Buttons.dart';

class classement_page extends StatelessWidget {
  int level = 0;
  int? id;
  classement_page(int lvl, {int? id}) {
    this.level = lvl;
    this.id = id;
  }

  List<String> players = [
    "p1",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2",
    "p2"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: BuildBasicLayout([
          const Text(
            "CLASSEMENT",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
                itemCount: players.length, // nombre d'éléments dans la liste
                itemBuilder: (context, index) => Stack(children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                            title: Row(children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                players[index],
                                style: const TextStyle(fontSize: 20.0),
                              )),
                          Expanded(
                              flex: 5,
                              child: Text(
                                "Mathéo",
                                style: const TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              )),
                          Expanded(
                              flex: 3,
                              child: Text(
                                "59:30",
                                style: const TextStyle(fontSize: 20.0),
                              )),
                        ])),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ])),
          ),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width * 0.8,
            child: footer(context),
          )
        ], false),
      ),
    );
  }

  Widget footer(BuildContext context) {
    if (id == Null) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DifficultySelectionPage()),
              );
            },
            child: const Text('RETOUR'),
            style: SecondaryButton,
          ),
        ],
      );
    }
    return Column(
      children: [
        Divider(
          color: Colors.white,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 200, 9, 222).withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Text(
                  "id.",
                  style: const TextStyle(fontSize: 20.0),
                )),
            Expanded(
                flex: 5,
                child: Text(
                  "Mathéo",
                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                )),
            Expanded(
                flex: 3,
                child: Text(
                  "59:30",
                  style: const TextStyle(fontSize: 20.0),
                )),
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('RETOUR'),
          style: SecondaryButton,
        ),
      ],
    );
  }

  //1ere version
  /** 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: MyHeaderDelegate(),
            ),
          ];
        },
        body: CustomScrollView(
          slivers: [
            SliverFixedExtentList(
              itemExtent: 30,
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text(
                    players[index],
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                childCount: players.length,
              ),
            )
          ],
        ),
      ),
    );
  }*/
}

// class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.blue,
//       child: Column(
//         children: [
//           Expanded(
//             child: Image.asset(
//               'assets/logo.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   double get maxExtent => 200.0;

//   @override
//   double get minExtent => 200.0;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }

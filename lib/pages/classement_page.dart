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
          SizedBox(
            height: 15,
          ),
          const Text(
            "CLASSEMENT",
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // height: 200,
            height: MediaQuery.of(context).size.height - 420,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                    itemCount:
                        players.length, // nombre d'éléments dans la liste
                    itemBuilder: (context, index) => Stack(children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                                title: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        players[index],
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )),
                                  Expanded(
                                      flex: 5,
                                      child: Text(
                                        "Mathéo",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        "59:30",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )),
                                ])),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ]))),
          ),
          Container(
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
            style: SecondaryButton(context),
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
                  "id.",
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  "Mathéo",
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            Expanded(
                flex: 3,
                child: Text(
                  "59:30",
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              width: 16,
            ),
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
          style: SecondaryButton(context),
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

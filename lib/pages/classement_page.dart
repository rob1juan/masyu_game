import 'package:flutter/material.dart';
import 'package:masyu_game/pages/difficulty_selection_page.dart';

class classement_page extends StatelessWidget {
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
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 200.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Color.dart';

List<Widget> BuildBasicLayout(List<Widget> children, bool showCredit) {
  if (showCredit) {
    children.addAll([
      Spacer(),
      Column(
        children: [
          Text('Created by',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
          SizedBox(height: 10),
          Text('ARMM',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w700)),
        ],
      ),
      SizedBox(height: 20),
    ]);
  }

  return [
    BackgroundGradient,
    Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 300,
            ),
          ] +
          children,
    ))
  ];
}

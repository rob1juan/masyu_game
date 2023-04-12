import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Color.dart';

List<Widget> BuildBasicLayout(List<Widget> children, bool showCredit) {
  if (showCredit) {
    children.addAll([
      const Spacer(),
      Column(
        children: const [
          Text('Created by',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
          SizedBox(height: 10),
          Text('ARMM',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w700)),
        ],
      ),
      const SizedBox(height: 20),
    ]);
  } else {
    children.add(Spacer());
  }

  return [
    BackgroundGradient,
    Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
            const SizedBox(height: 50),
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 175,
            ),
          ] +
          children,
    ))
  ];
}

List<Widget> BuildFinishLayout(List<Widget> children) {
  return [
    BackgroundGradient,
    Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
            SizedBox(height: 50),
          ] +
          children,
    ))
  ];
}

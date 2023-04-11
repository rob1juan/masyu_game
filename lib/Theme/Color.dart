import 'package:flutter/material.dart';

Color primary = Color(0xFFE656FD);
Color secondary = Color(0xFFFF9FF3);
Color yellow = Color(0xFFFED330);
Color success = Color(0xFF6AB04C);
Color warning = Color(0xFFF0932B);
Color danger = Color(0xFFEB4D4B);

Container BackgroundGradient = Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFBE2EDD),
        Color(0xFF902EDD),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
);

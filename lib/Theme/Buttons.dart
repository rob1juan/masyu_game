import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Color.dart';

ButtonStyle PrimaryButton = ElevatedButton.styleFrom(
  backgroundColor: primary,
  minimumSize: Size(225, 65),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  shadowColor: Colors.black,
  elevation: 10.0,
  textStyle: TextStyle(fontWeight: FontWeight.w700),
);

ButtonStyle SecondaryButton = ElevatedButton.styleFrom(
  backgroundColor: secondary,
  minimumSize: Size(225, 65),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  shadowColor: Colors.black,
  elevation: 10.0,
  textStyle: TextStyle(fontWeight: FontWeight.w700),
);

ButtonStyle YellowButton = ElevatedButton.styleFrom(
  backgroundColor: yellow,
  minimumSize: Size(225, 65),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  shadowColor: Colors.black,
  elevation: 10.0,
  textStyle: TextStyle(fontWeight: FontWeight.w700),
);

ButtonStyle SuccessButton = ElevatedButton.styleFrom(
  backgroundColor: success,
  minimumSize: Size(225, 65),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  shadowColor: Colors.black,
  elevation: 10.0,
  textStyle: TextStyle(fontWeight: FontWeight.w700),
);

ButtonStyle WarningButton = ElevatedButton.styleFrom(
  backgroundColor: warning,
  minimumSize: Size(225, 65),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  shadowColor: Colors.black,
  elevation: 10.0,
  textStyle: TextStyle(fontWeight: FontWeight.w700),
);

ButtonStyle DangerButton = ElevatedButton.styleFrom(
  backgroundColor: danger,
  minimumSize: Size(225, 65),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  shadowColor: Colors.black,
  elevation: 10.0,
  textStyle: TextStyle(fontWeight: FontWeight.w700),
);
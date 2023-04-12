import 'package:flutter/material.dart';
import 'package:masyu_game/Theme/Color.dart';

ButtonStyle buttonStyleWithSize(
    Color backgroundColor, double minWidth, double minHeight) {
  return ElevatedButton.styleFrom(
    backgroundColor: backgroundColor,
    minimumSize: Size(minWidth, minHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    shadowColor: Colors.black,
    elevation: 10.0,
    textStyle: TextStyle(fontWeight: FontWeight.w700),
  );
}

ButtonStyle responsiveButtonStyle(BuildContext context, Color backgroundColor) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  double minWidth = screenWidth * 0.5;
  double minHeight = screenHeight * 0.075;

  return buttonStyleWithSize(backgroundColor, minWidth, minHeight);
}

ButtonStyle PrimaryButton(BuildContext context) =>
    responsiveButtonStyle(context, primary);
ButtonStyle SecondaryButton(BuildContext context) =>
    responsiveButtonStyle(context, secondary);
ButtonStyle ClassementButton(BuildContext context) =>
    buttonStyleWithSize(secondary, 65, 65);
ButtonStyle YellowButton(BuildContext context) =>
    responsiveButtonStyle(context, yellow);
ButtonStyle SuccessButton(BuildContext context) =>
    responsiveButtonStyle(context, success);
ButtonStyle WarningButton(BuildContext context) =>
    responsiveButtonStyle(context, warning);
ButtonStyle DangerButton(BuildContext context) =>
    responsiveButtonStyle(context, danger);
ButtonStyle ShareButton(BuildContext context) =>
    buttonStyleWithSize(secondary, 196, 48);

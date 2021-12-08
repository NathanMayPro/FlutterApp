import 'package:flutter/material.dart';

class CommonStyle {
  static const Color backGroundColor = Colors.white;

  static const Color backGroundArticleColor = Colors.grey;

  static const Color backGroundSettingsColor = Colors.blueGrey;

  static const Color iconActiveColor = Colors.grey;

  static const Color iconInactiveColor = Colors.black;

  static const Icon iconValidatorSettings = Icon(Icons.ac_unit);

  static InputDecoration textFieldStyle(
      {String labelTextStr = "", String hintTextStr = ""}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      labelText: labelTextStr,
      hintText: hintTextStr,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
      ),
    );
  }
}

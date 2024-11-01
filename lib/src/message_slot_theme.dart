import 'package:flutter/material.dart';

class BubblegumMessageSlotTheme {
  static Color colorOfSlot(ThemeData themeData) {
    if (themeData.colorScheme.brightness == Brightness.light) {
      return Colors.grey.shade500;
    } else {
      return Colors.white70;
    }
  }
}

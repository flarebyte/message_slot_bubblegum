import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

class BubblegumMessageSlotTheme {
  static Color colorOfSlot(ThemeData themeData) {
    if (themeData.colorScheme.brightness == Brightness.light) {
      return Colors.grey.shade500;
    } else {
      return Colors.white70;
    }
  }

  static Color getBadgeColor(
      ThemeData themeData, CopperframeMessageLevel level) {
    switch (level) {
      case CopperframeMessageLevel.error:
        return Colors.red.shade900;
      case CopperframeMessageLevel.warning:
        return Colors.orange.shade700;
      case CopperframeMessageLevel.info:
        return Colors.blue.shade900;
      default:
        return Colors.grey.shade800;
    }
  }
}

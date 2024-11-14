import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

enum TShirtSize { extraSmall, small, medium, large, extraLarge }

const slotBoxDecorationWidth = {
  TShirtSize.extraSmall: .5,
  TShirtSize.small: 1.0,
  TShirtSize.medium: 2.0,
  TShirtSize.large: 4.0,
  TShirtSize.extraLarge: 6.0,
};

class BubblegumMessageSlotTheme {
  static Color colorOfSlot(ThemeData themeData) {
    if (themeData.colorScheme.brightness == Brightness.light) {
      return Colors.grey.shade500;
    } else {
      return Colors.white70;
    }
  }

  static Color colorOfHeaderDivider(ThemeData themeData) {
    if (themeData.colorScheme.brightness == Brightness.light) {
      return Colors.grey.shade500;
    } else {
      return Colors.white70;
    }
  }

  static BoxDecoration getSlotBoxDecoration(
      {required ThemeData themeData, required TShirtSize shirtSize}) {
    return BoxDecoration(
      border: Border.all(
          width: slotBoxDecorationWidth[shirtSize] ?? 1.0,
          color: BubblegumMessageSlotTheme.colorOfSlot(themeData)),
      borderRadius: BorderRadius.circular(12),
    );
  }
}

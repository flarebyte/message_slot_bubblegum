import 'package:flutter/material.dart';

/// Enum representing different T-shirt sizes.
///
/// This is used for defining different sizes for UI elements such as box decorations.
enum TShirtSize { extraSmall, small, medium, large, extraLarge }

/// A constant map that defines the width of slot box decorations based on the T-shirt size.
///
/// The sizes range from extraSmall to extraLarge, each associated with a specific width.
const slotBoxDecorationWidth = {
  TShirtSize.extraSmall: .5,
  TShirtSize.small: 1.0,
  TShirtSize.medium: 2.0,
  TShirtSize.large: 4.0,
  TShirtSize.extraLarge: 6.0,
};

/// A theme utility class for defining the appearance of the Bubblegum message slot.
///
/// This class provides methods to get colors and decorations for message slots based on the current theme.
class BubblegumMessageSlotTheme {
  /// Returns the color to be used for a slot based on the current [themeData].
  ///
  /// If the theme brightness is light, it returns a shade of grey. Otherwise, it returns a white shade.
  static Color colorOfSlot(ThemeData themeData) {
    if (themeData.colorScheme.brightness == Brightness.light) {
      return Colors.grey.shade500;
    } else {
      return Colors.white70;
    }
  }

  /// Returns the color to be used for the header divider based on the current [themeData].
  ///
  /// If the theme brightness is light, it returns a shade of grey. Otherwise, it returns a white shade.
  static Color colorOfHeaderDivider(ThemeData themeData) {
    if (themeData.colorScheme.brightness == Brightness.light) {
      return Colors.grey.shade500;
    } else {
      return Colors.white70;
    }
  }

  /// Returns a [BoxDecoration] for a message slot based on the given [themeData] and [shirtSize].
  ///
  /// The decoration includes a border whose width is defined by the [shirtSize] and a rounded corner.
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

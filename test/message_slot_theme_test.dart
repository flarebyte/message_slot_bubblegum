import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:message_slot_bubblegum/src/message_slot_theme.dart';

void main() {
  group('BubblegumMessageSlotTheme Unit Tests', () {
    test('colorOfSlot returns correct color for light theme', () {
      // Arrange
      final lightTheme = ThemeData(brightness: Brightness.light);

      // Act
      final color = BubblegumMessageSlotTheme.colorOfSlot(lightTheme);

      // Assert
      expect(color, Colors.grey.shade500);
    });

    test('colorOfSlot returns correct color for dark theme', () {
      // Arrange
      final darkTheme = ThemeData(brightness: Brightness.dark);

      // Act
      final color = BubblegumMessageSlotTheme.colorOfSlot(darkTheme);

      // Assert
      expect(color, Colors.white70);
    });

    test('colorOfHeaderDivider returns correct color for light theme', () {
      // Arrange
      final lightTheme = ThemeData(brightness: Brightness.light);

      // Act
      final color = BubblegumMessageSlotTheme.colorOfHeaderDivider(lightTheme);

      // Assert
      expect(color, Colors.grey.shade500);
    });

    test('colorOfHeaderDivider returns correct color for dark theme', () {
      // Arrange
      final darkTheme = ThemeData(brightness: Brightness.dark);

      // Act
      final color = BubblegumMessageSlotTheme.colorOfHeaderDivider(darkTheme);

      // Assert
      expect(color, Colors.white70);
    });

    test('getSlotBoxDecoration returns correct decoration for given TShirtSize',
        () {
      // Arrange
      final themeData = ThemeData(brightness: Brightness.light);

      // Act
      final decoration = BubblegumMessageSlotTheme.getSlotBoxDecoration(
        themeData: themeData,
        shirtSize: TShirtSize.medium,
      );

      // Assert
      expect(decoration.border, isNotNull);
      expect((decoration.border as Border).top.width, 2.0);
      expect((decoration.border as Border).top.color, Colors.grey.shade500);
      expect(decoration.borderRadius, BorderRadius.circular(12));
    });
  });
}

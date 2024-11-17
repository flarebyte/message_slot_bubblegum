import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';
import 'package:message_slot_bubblegum/src/message_badge_widget.dart';
import 'package:message_slot_bubblegum/src/message_bar_slot.dart';

import 'widget_data.dart';

void main() {
  group('BubblegumMessageBarSlot Integration Tests', () {
    // Define mock messages

    // Define mock options
    final options = BubblegumMessageSlotOptsBuilder().build();

    testWidgets('Displays the slot title in uppercase',
        (WidgetTester tester) async {
      // Arrange: Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumMessageBarSlot(
              slot: WidgetData.createSlot(),
              messages: const [],
              options: options,
            ),
          ),
        ),
      );

      // Assert: Slot title should be displayed in uppercase
      expect(find.text('SOME TITLE'), findsOneWidget);
    });

    testWidgets('Displays the slot description as a tooltip',
        (WidgetTester tester) async {
      // Arrange: Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumMessageBarSlot(
              slot: WidgetData.createSlot(),
              messages: const [],
              options: options,
            ),
          ),
        ),
      );

      // Act: Hover over the title text to show tooltip
      final titleFinder = find.text('SOME TITLE');
      await tester.ensureVisible(titleFinder);
      await tester.tap(titleFinder);
      await tester.pumpAndSettle();

      // Assert: Tooltip should contain the description text
      expect(
          find.byTooltip('This is a test slot description.'), findsOneWidget);
    });

    testWidgets('Displays the badge widget when messages are present',
        (WidgetTester tester) async {
      // Arrange: Build the widget with messages
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumMessageBarSlot(
              slot: WidgetData.createSlot(),
              messages: [
                WidgetData.createCopperframeMessage(
                    CopperframeMessageLevel.info),
                WidgetData.createCopperframeMessage(
                    CopperframeMessageLevel.warning),
              ],
              options: options,
            ),
          ),
        ),
      );

      // Assert: Badge widget should be visible
      expect(find.byType(BubblegumLevelBadgeWidget), findsOneWidget);
    });

    testWidgets('Does not display the badge widget when there are no messages',
        (WidgetTester tester) async {
      // Arrange: Build the widget with no messages
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumMessageBarSlot(
              slot: WidgetData.createSlot(),
              messages: const [],
              options: options,
            ),
          ),
        ),
      );

      // Assert: Badge widget should not be visible
      expect(find.byType(BubblegumLevelBadgeWidget), findsNothing);
    });
  });
}

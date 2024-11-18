import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';
import 'package:message_slot_bubblegum/src/fixed_size_message_widget.dart';
import 'package:message_slot_bubblegum/src/message_bar_slot.dart';
import 'package:message_slot_bubblegum/src/message_slot_theme.dart';

import 'widget_data.dart';

void main() {
  group('BubblegumMessageSlot Integration Tests', () {
    // Define mock messages
    final mockMessages = [
      WidgetData.createCopperframeMessage(CopperframeMessageLevel.info),
      WidgetData.createCopperframeMessage(CopperframeMessageLevel.warning),
      WidgetData.createCopperframeMessage(CopperframeMessageLevel.error),
    ];

    // Define mock options
    final mockOptions = BubblegumMessageSlotOptsBuilder()
        .setIconCollection(WidgetData.iconCollection)
        .build();

    testWidgets('Displays slot content based on size',
        (WidgetTester tester) async {
      // Arrange: Set slot size to medium
      final mediumSlot = WidgetData.createSlot(size: 'medium');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumMessageSlot(
              slot: mediumSlot,
              messages: mockMessages,
              options: mockOptions,
            ),
          ),
        ),
      );

      // Assert: The medium-sized slot should use BubblegumFixedSizeMessageWidget with maxMessages of 5
      expect(find.byType(BubblegumFixedSizeMessageWidget), findsOneWidget);
      final widget = tester.widget<BubblegumFixedSizeMessageWidget>(
          find.byType(BubblegumFixedSizeMessageWidget));
      expect(widget.maxMessages, 5);
    });

    testWidgets('Displays bar slot content correctly',
        (WidgetTester tester) async {
      // Arrange: Set slot size to bar
      final barSlot = WidgetData.createSlot(size: 'bar');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumMessageSlot(
              slot: barSlot,
              messages: mockMessages,
              options: mockOptions,
            ),
          ),
        ),
      );

      // Assert: The slot should use BubblegumMessageBarSlot
      expect(find.byType(BubblegumMessageBarSlot), findsOneWidget);
    });

    testWidgets('Displays correct widget for large slot size',
        (WidgetTester tester) async {
      // Arrange: Set slot size to large
      final largeSlot = WidgetData.createSlot(size: 'large');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumMessageSlot(
              slot: largeSlot,
              messages: mockMessages,
              options: mockOptions,
            ),
          ),
        ),
      );

      // Assert: The large-sized slot should use BubblegumFixedSizeMessageWidget with maxMessages of 8
      expect(find.byType(BubblegumFixedSizeMessageWidget), findsOneWidget);
      final widget = tester.widget<BubblegumFixedSizeMessageWidget>(
          find.byType(BubblegumFixedSizeMessageWidget));
      expect(widget.maxMessages, 8);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';
import 'package:message_slot_bubblegum/src/fixed_size_message_widget.dart';

import 'widget_data.dart';

void main() {
  group('BubblegumFixedSizeMessageWidget Integration Tests', () {
    // Define a mock CopperframeSlotBase
    final mockSlot = WidgetData.createSlot();

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

    testWidgets('Displays the slot header correctly',
        (WidgetTester tester) async {
      // Arrange: Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumFixedSizeMessageWidget(
              messages: mockMessages,
              slot: mockSlot,
              maxMessages: 3,
              options: mockOptions,
            ),
          ),
        ),
      );

      // Assert: Slot header should be visible with the correct title
      expect(find.text('SOME TITLE'), findsOneWidget);
    });

    testWidgets('Displays up to the maximum number of messages',
        (WidgetTester tester) async {
      // Arrange: Build the widget with maxMessages set to 2
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumFixedSizeMessageWidget(
              messages: mockMessages,
              slot: mockSlot,
              maxMessages: 2,
              options: mockOptions,
            ),
          ),
        ),
      );

      // Assert: Only 2 messages should be displayed
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets(
        'Displays an indicator if there are more messages than maxMessages',
        (WidgetTester tester) async {
      // Arrange: Build the widget with maxMessages set to 2
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumFixedSizeMessageWidget(
              messages: mockMessages,
              slot: mockSlot,
              maxMessages: 2,
              options: mockOptions,
            ),
          ),
        ),
      );

      // Assert: The "more" indicator should be visible
      expect(find.byIcon(Icons.more_horiz_sharp), findsOneWidget);
    });

    testWidgets('Displays correct icon for each message level',
        (WidgetTester tester) async {
      // Arrange: Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumFixedSizeMessageWidget(
              messages: mockMessages,
              slot: mockSlot,
              maxMessages: 3,
              options: mockOptions,
            ),
          ),
        ),
      );

      // Assert: Icons corresponding to the message levels should be present
      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('Triggers onTap and onLongPress callbacks when set',
        (WidgetTester tester) async {
      bool tapped = false;
      bool longPressed = false;

      // Define mock options with tap and long press handlers
      final optionsWithCallbacks = BubblegumMessageSlotOptsBuilder()
          .setIconCollection(WidgetData.iconCollection)
          .setOnMessageTap((_) => tapped = true)
          .setOnMessageLongPress((_) => longPressed = true)
          .build();

      // Arrange: Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BubblegumFixedSizeMessageWidget(
              messages: mockMessages,
              slot: mockSlot,
              maxMessages: 3,
              options: optionsWithCallbacks,
            ),
          ),
        ),
      );

      // Act: Tap and long press on the first message
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();
      await tester.longPress(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      // Assert: Both callbacks should be triggered
      expect(tapped, isTrue);
      expect(longPressed, isTrue);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';
import 'package:message_slot_bubblegum/src/message_badge_widget.dart';

import 'widget_data.dart';

void main() {
  group('BubblegumLevelBadgeWidget Tests', () {
    testWidgets('Displays the correct number of messages in badge',
        (WidgetTester tester) async {
      // Arrange
      final messages = [
        WidgetData.createCopperframeMessage(CopperframeMessageLevel.info),
        WidgetData.createCopperframeMessage(CopperframeMessageLevel.warning),
        WidgetData.createCopperframeMessage(CopperframeMessageLevel.error),
      ];
      final options = BubblegumMessageSlotOptsBuilder().build();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BubblegumLevelBadgeWidget(
            messages: messages,
            options: options,
          ),
        ),
      );

      // Assert
      expect(find.text('3'), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('Returns empty widget when there are no messages',
        (WidgetTester tester) async {
      // Arrange
      final messages = <CopperframeMessage>[];
      final options = BubblegumMessageSlotOptsBuilder().build();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BubblegumLevelBadgeWidget(
            messages: messages,
            options: options,
          ),
        ),
      );

      // Assert
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets(
        'Displays correct icon color based on the highest message level',
        (WidgetTester tester) async {
      // Arrange
      final messages = [
        WidgetData.createCopperframeMessage(CopperframeMessageLevel.info),
        WidgetData.createCopperframeMessage(CopperframeMessageLevel.error),
      ];
      final options = BubblegumMessageSlotOptsBuilder()
          .setIconCollection(WidgetData.iconCollection)
          .build();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BubblegumLevelBadgeWidget(
            messages: messages,
            options: options,
          ),
        ),
      );

      // Assert
      final icon = tester.widget<Icon>(find.byIcon(Icons.notifications));
      expect(icon.color, Colors.red);
    });

    testWidgets('Accessibility check: badge has correct semantic label',
        (WidgetTester tester) async {
      // Arrange
      final messages = [
        WidgetData.createCopperframeMessage(CopperframeMessageLevel.warning),
      ];
      final options = BubblegumMessageSlotOptsBuilder().build();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BubblegumLevelBadgeWidget(
            messages: messages,
            options: options,
          ),
        ),
      );

      // Assert
      final icon = tester.widget<Icon>(find.byIcon(Icons.notifications));
      expect(
          icon.semanticLabel, options.messageLabelForLevel(messages[0].level));
    });

    testWidgets('Follows a11y guidelines', (tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      final messages = [
        WidgetData.createCopperframeMessage(CopperframeMessageLevel.warning),
      ];
      final options = BubblegumMessageSlotOptsBuilder().build();

      await tester.pumpWidget(
        MaterialApp(
          home: BubblegumLevelBadgeWidget(
            messages: messages,
            options: options,
          ),
        ),
      );

      // Checks that tappable nodes have a minimum size of 48 by 48 pixels
      // for Android.
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

      // Checks that tappable nodes have a minimum size of 44 by 44 pixels
      // for iOS.
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

      // Checks that touch targets with a tap or long press action are labeled.
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

      // Checks whether semantic nodes meet the minimum text contrast levels.
      // The recommended text contrast is 3:1 for larger text
      // (18 point and above regular).
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
  });
}

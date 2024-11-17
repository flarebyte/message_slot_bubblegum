import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';
import 'package:message_slot_bubblegum/src/message_badge_widget.dart';

void main() {
  CopperframeMessage createCopperframeMessage(CopperframeMessageLevel level) =>
      CopperframeMessage(level: level, label: level.name, category: 'any');
  final BubblegumIconInfo placeholder = BubblegumIconInfo(
      key: 'placeholder', icon: const Icon(Icons.info, color: Colors.grey));
  final BubblegumIconInfo info = BubblegumIconInfo(
      key: 'info',
      icon: const Icon(
        Icons.info,
        color: Colors.blue,
        semanticLabel: 'info',
      ));
  final BubblegumIconInfo warning = BubblegumIconInfo(
    key: 'warning',
    icon: const Icon(Icons.warning,
        color: Colors.orange, semanticLabel: 'warning'),
  );
  final BubblegumIconInfo error = BubblegumIconInfo(
      key: 'error',
      icon: const Icon(Icons.error, color: Colors.red, semanticLabel: 'error'));
  BubblegumIconCollection iconCollection = BubblegumIconCollection(
      defaultContent: placeholder,
      icons: [info, warning, error],
      maxIcons: 2,
      priorityKeys: [error.key, warning.key]);
  group('BubblegumLevelBadgeWidget Tests', () {
    testWidgets('Displays the correct number of messages in badge',
        (WidgetTester tester) async {
      // Arrange
      final messages = [
        createCopperframeMessage(CopperframeMessageLevel.info),
        createCopperframeMessage(CopperframeMessageLevel.warning),
        createCopperframeMessage(CopperframeMessageLevel.error),
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
        createCopperframeMessage(CopperframeMessageLevel.info),
        createCopperframeMessage(CopperframeMessageLevel.error),
      ];
      final options = BubblegumMessageSlotOptsBuilder()
          .setIconCollection(iconCollection)
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
        createCopperframeMessage(CopperframeMessageLevel.warning),
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
  });
}

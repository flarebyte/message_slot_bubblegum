import 'package:flutter_test/flutter_test.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/src/message_helper.dart';

void main() {
  group('BubblegumMessageHelper Unit Tests', () {
    final mockMessages = [
      CopperframeMessage(
          level: CopperframeMessageLevel.info,
          label: 'Info Message 1',
          category: 'category'),
      CopperframeMessage(
          level: CopperframeMessageLevel.warning,
          label: 'Warning Message 1',
          category: 'category'),
      CopperframeMessage(
          level: CopperframeMessageLevel.error,
          label: 'Error Message 1',
          category: 'category'),
      CopperframeMessage(
          level: CopperframeMessageLevel.info,
          label: 'Info Message 2',
          category: 'category'),
      CopperframeMessage(
          level: CopperframeMessageLevel.warning,
          label: 'Warning Message 2',
          category: 'category'),
    ];

    test('groupMessages should return messages grouped by severity', () {
      // Act
      final groupedMessages =
          BubblegumMessageHelper.groupMessages(mockMessages);

      // Assert: Errors should come first, followed by warnings, then info messages
      expect(groupedMessages[0].level, CopperframeMessageLevel.error);
      expect(groupedMessages[1].level, CopperframeMessageLevel.warning);
      expect(groupedMessages[2].level, CopperframeMessageLevel.warning);
      expect(groupedMessages[3].level, CopperframeMessageLevel.info);
      expect(groupedMessages[4].level, CopperframeMessageLevel.info);
    });

    test(
        'getMessageCountByLevel should return the correct count for each level',
        () {
      // Act & Assert
      expect(
          BubblegumMessageHelper.getMessageCountByLevel(
              mockMessages, CopperframeMessageLevel.error),
          1);
      expect(
          BubblegumMessageHelper.getMessageCountByLevel(
              mockMessages, CopperframeMessageLevel.warning),
          2);
      expect(
          BubblegumMessageHelper.getMessageCountByLevel(
              mockMessages, CopperframeMessageLevel.info),
          2);
    });

    test('getHighestLevel should return the highest severity present', () {
      // Act & Assert
      expect(BubblegumMessageHelper.getHighestLevel(mockMessages),
          CopperframeMessageLevel.error);

      final infoAndWarningMessages = mockMessages
          .where((msg) => msg.level != CopperframeMessageLevel.error)
          .toList();
      expect(BubblegumMessageHelper.getHighestLevel(infoAndWarningMessages),
          CopperframeMessageLevel.warning);

      final infoMessagesOnly = mockMessages
          .where((msg) => msg.level == CopperframeMessageLevel.info)
          .toList();
      expect(BubblegumMessageHelper.getHighestLevel(infoMessagesOnly),
          CopperframeMessageLevel.info);
    });

    test('limitMessages should return the limited number of messages', () {
      // Act
      final limitedMessages =
          BubblegumMessageHelper.limitMessages(mockMessages, maxMessages: 3);

      // Assert
      expect(limitedMessages.length, 3);
    });

    test('limitMessages should respect slotMaxMessages if provided', () {
      // Act
      final limitedMessages = BubblegumMessageHelper.limitMessages(mockMessages,
          maxMessages: 3, slotMaxMessages: 2);

      // Assert
      expect(limitedMessages.length, 2);
    });
  });
}

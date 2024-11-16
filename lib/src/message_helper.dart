import 'package:grand_copperframe/grand_copperframe.dart';

class BubblegumMessageHelper {
  static List<CopperframeMessage> groupMessages(
      List<CopperframeMessage> messages) {
    final errors = messages
        .where((msg) => msg.level == CopperframeMessageLevel.error)
        .toList();
    final warnings = messages
        .where((msg) => msg.level == CopperframeMessageLevel.warning)
        .toList();
    final info = messages
        .where((msg) => msg.level == CopperframeMessageLevel.info)
        .toList();
    return [...errors, ...warnings, ...info];
  }

  static int getMessageCountByLevel(
      List<CopperframeMessage> messages, CopperframeMessageLevel level) {
    return messages.where((msg) => msg.level == level).length;
  }

  static CopperframeMessageLevel getHighestLevel(
      List<CopperframeMessage> messages) {
    if (getMessageCountByLevel(messages, CopperframeMessageLevel.error) > 0) {
      return CopperframeMessageLevel.error;
    }
    if (getMessageCountByLevel(messages, CopperframeMessageLevel.warning) > 0) {
      return CopperframeMessageLevel.warning;
    }
    return CopperframeMessageLevel.info;
  }

  static List<CopperframeMessage> limitMessages(
      List<CopperframeMessage> displayedMessages,
      {required int maxMessages,
      int? slotMaxMessages}) {
    final int limit = slotMaxMessages ?? maxMessages;
    final limitedMessages = displayedMessages.take(limit).toList();
    return limitedMessages;
  }
}

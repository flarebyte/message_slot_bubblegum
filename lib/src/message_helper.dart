import 'package:grand_copperframe/grand_copperframe.dart';

/// A utility class providing helper methods for managing and grouping Copperframe messages.
///
/// This class contains methods to group messages by level, count messages, determine the highest level,
/// and limit the number of messages displayed.
class BubblegumMessageHelper {
  /// Groups the given list of [messages] by their level, returning a list where errors are first,
  /// followed by warnings, and then info messages.
  ///
  /// This helps to prioritize messages by severity when displaying them.
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

  /// Returns the count of messages of a specific [level] from the provided list of [messages].
  ///
  /// This can be useful to determine how many messages of a particular type (e.g., error) are present.
  static int getMessageCountByLevel(
      List<CopperframeMessage> messages, CopperframeMessageLevel level) {
    return messages.where((msg) => msg.level == level).length;
  }

  /// Determines the highest message level from the given list of [messages].
  ///
  /// The hierarchy is: error > warning > info. The method returns the highest level present in the list.
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

  /// Limits the number of messages in the given list of [displayedMessages] to a specified maximum.
  ///
  /// The [maxMessages] parameter specifies the general limit, while [slotMaxMessages], if provided,
  /// can override this limit for specific slots.
  static List<CopperframeMessage> limitMessages(
      List<CopperframeMessage> displayedMessages,
      {required int maxMessages,
      int? slotMaxMessages}) {
    final int limit = slotMaxMessages ?? maxMessages;
    final limitedMessages = displayedMessages.take(limit).toList();
    return limitedMessages;
  }
}

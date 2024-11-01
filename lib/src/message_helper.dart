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
}

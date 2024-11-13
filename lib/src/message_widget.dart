import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

import 'icon_collection.dart';
import 'message_slot_theme.dart';

class BubblegumMessageWidget extends StatelessWidget {
  const BubblegumMessageWidget({
    super.key,
    required this.msg,
  });

  final CopperframeMessage msg;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: BubblegumMessageWidget(msg: msg),
    );
  }
}

class MessageLevelIcon extends StatelessWidget {
  const MessageLevelIcon({
    super.key,
    required this.level,
    required this.iconCollection,
  });

  final CopperframeMessageLevel level;
  final BubblegumIconCollection iconCollection;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    switch (level) {
      case CopperframeMessageLevel.error:
        return Icon(Icons.error,
            color: BubblegumMessageSlotTheme.getLevelColor(themeData, level));
      case CopperframeMessageLevel.warning:
        return Icon(Icons.warning,
            color: BubblegumMessageSlotTheme.getLevelColor(themeData, level));
      case CopperframeMessageLevel.info:
        return Icon(Icons.info,
            color: BubblegumMessageSlotTheme.getLevelColor(themeData, level));
      default:
        return Icon(Icons.message,
            color: BubblegumMessageSlotTheme.getLevelColor(themeData, level));
    }
  }
}

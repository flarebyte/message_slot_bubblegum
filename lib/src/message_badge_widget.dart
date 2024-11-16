import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

import '../message_slot_bubblegum.dart';
import 'message_helper.dart';

class BubblegumMessageBadgeWidget extends StatelessWidget {
  const BubblegumMessageBadgeWidget(
      {super.key,
      required this.messages,
      required this.showBadgesWhenEmpty,
      required this.level,
      required this.iconCollection});

  final List<CopperframeMessage> messages;
  final bool showBadgesWhenEmpty;
  final CopperframeMessageLevel level;
  final BubblegumIconCollection iconCollection;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final int count =
        BubblegumMessageHelper.getMessageCountByLevel(messages, level);
    if (count == 0 && !showBadgesWhenEmpty) {
      return const SizedBox.shrink();
    }
    return Badge.count(
      count: count,
      child: Icon(iconCollection.findIconByKeyOrDefault(level.name).icon.icon,
          color: themeData.textTheme.titleMedium?.color ?? Colors.blue),
    );
  }
}

class BubblegumLevelBadgeWidget extends StatelessWidget {
  const BubblegumLevelBadgeWidget(
      {super.key,
      required this.messages,
      required this.showBadgesWhenEmpty,
      required this.iconCollection});

  final List<CopperframeMessage> messages;
  final bool showBadgesWhenEmpty;
  final BubblegumIconCollection iconCollection;

  @override
  Widget build(BuildContext context) {
    final highestLevel = BubblegumMessageHelper.getHighestLevel(messages);
    if (messages.isEmpty) {
      return const SizedBox.shrink();
    }
    return Badge.count(
      count: messages.length,
      child: Icon(Icons.notifications,
          color: iconCollection
              .findIconByKeyOrDefault(highestLevel.name)
              .icon
              .color),
    );
  }
}

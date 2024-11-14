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
    final int count =
        BubblegumMessageHelper.getMessageCountByLevel(messages, level);
    if (count == 0 && !showBadgesWhenEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: iconCollection.findIconByKeyOrDefault(level.name).icon.color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$count'),
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
    return Row(
      children: [
        BubblegumMessageBadgeWidget(
            messages: messages,
            showBadgesWhenEmpty: showBadgesWhenEmpty,
            level: CopperframeMessageLevel.error,
            iconCollection: iconCollection),
        BubblegumMessageBadgeWidget(
            messages: messages,
            showBadgesWhenEmpty: showBadgesWhenEmpty,
            level: CopperframeMessageLevel.warning,
            iconCollection: iconCollection),
        BubblegumMessageBadgeWidget(
            messages: messages,
            showBadgesWhenEmpty: showBadgesWhenEmpty,
            level: CopperframeMessageLevel.info,
            iconCollection: iconCollection),
      ],
    );
  }
}

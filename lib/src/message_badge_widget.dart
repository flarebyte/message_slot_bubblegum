import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

import '../message_slot_bubblegum.dart';
import 'message_helper.dart';

class BubblegumLevelBadgeWidget extends StatelessWidget {
  const BubblegumLevelBadgeWidget(
      {super.key, required this.messages, required this.options});

  final List<CopperframeMessage> messages;
  final BubblegumMessageSlotOptions options;

  @override
  Widget build(BuildContext context) {
    final highestLevel = BubblegumMessageHelper.getHighestLevel(messages);
    if (messages.isEmpty) {
      return const SizedBox.shrink();
    }
    return Badge.count(
      count: messages.length,
      child: Icon(Icons.notifications,
          semanticLabel: options.messageLabelForLevel(highestLevel),
          color: options.iconCollection
              .findIconByKeyOrDefault(highestLevel.name)
              .icon
              .color),
    );
  }
}

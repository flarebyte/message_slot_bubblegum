import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'message_badge_widget.dart';

class BubblegumMessageBarSlot extends StatelessWidget {
  const BubblegumMessageBarSlot({
    super.key,
    required this.slot,
    required this.showBadgesWhenEmpty,
    required this.messages,
  });

  final CopperframeSlotBase slot;
  final bool showBadgesWhenEmpty;
  final List<CopperframeMessage> messages;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Text(slot.title.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        Tooltip(message: slot.description, child: const Icon(Icons.help)),
        const SizedBox(width: 8),
        if (showBadgesWhenEmpty || messages.isNotEmpty)
          BubblegumLevelBadgeWidget(
              messages: messages, showBadgesWhenEmpty: showBadgesWhenEmpty),
      ],
    );
  }
}

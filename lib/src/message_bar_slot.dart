import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import '../message_slot_bubblegum.dart';
import 'message_badge_widget.dart';

class BubblegumMessageBarSlot extends StatelessWidget {
  const BubblegumMessageBarSlot({
    super.key,
    required this.slot,
    required this.messages,
    required this.options,
  });

  final CopperframeSlotBase slot;
  final List<CopperframeMessage> messages;
  final BubblegumMessageSlotOptions options;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Tooltip(
            message: slot.description,
            child: Text(slot.title.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold))),
        const Spacer(),
        const SizedBox(width: 8),
        if (messages.isNotEmpty)
          BubblegumLevelBadgeWidget(messages: messages, options: options),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'message_bar_slot.dart';
import 'message_helper.dart';
import 'message_slot_theme.dart';
import 'message_widget.dart';

class BubblegumFixedSizeMessageWidget extends StatelessWidget {
  const BubblegumFixedSizeMessageWidget({
    super.key,
    required this.groupMessagesByLevel,
    required this.messages,
    required this.messageLimits,
    required this.slot,
    required this.maxMessages,
  });

  final bool groupMessagesByLevel;
  final List<CopperframeMessage> messages;
  final Map<String, int> messageLimits;
  final CopperframeSlotBase slot;
  final int maxMessages;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final List<CopperframeMessage> displayedMessages = groupMessagesByLevel
        ? BubblegumMessageHelper.groupMessages(messages)
        : messages;
    final int limit = messageLimits[slot.size] ?? maxMessages;
    final limitedMessages = displayedMessages.take(limit).toList();
    final isAboveLimit = displayedMessages.length > limitedMessages.length;
    final messageTiles = limitedMessages
        .map((msg) => ListTile(
            title: Text(msg.label, textAlign: TextAlign.justify),
            leading: Column(children: [
              MessageLevelIcon(level: msg.level),
              const Icon(Icons.access_alarm)
            ])))
        .toList();
    final header = BubblegumMessageBarSlot(
        slot: slot, showBadgesWhenEmpty: false, messages: messages);
    final dividerHeader = Divider(
        color: BubblegumMessageSlotTheme.colorOfHeaderDivider(themeData));
    final toContinue = isAboveLimit
        ? [
            const Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.more_horiz_sharp)),
          ]
        : [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [header, dividerHeader, ...messageTiles, ...toContinue],
    );
  }
}

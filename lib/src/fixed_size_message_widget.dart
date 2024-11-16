import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'icon_collection.dart';
import 'message_bar_slot.dart';
import 'message_helper.dart';
import 'message_slot_theme.dart';

class BubblegumFixedSizeMessageWidget extends StatelessWidget {
  const BubblegumFixedSizeMessageWidget({
    super.key,
    required this.groupMessagesByLevel,
    required this.messages,
    required this.messageLimits,
    required this.slot,
    required this.maxMessages,
    required this.iconCollection,
  });

  final bool groupMessagesByLevel;
  final List<CopperframeMessage> messages;
  final Map<String, int> messageLimits;
  final CopperframeSlotBase slot;
  final int maxMessages;
  final BubblegumIconCollection iconCollection;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final List<CopperframeMessage> displayedMessages = groupMessagesByLevel
        ? BubblegumMessageHelper.groupMessages(messages)
        : messages;
    List<CopperframeMessage> limitedMessages =
        BubblegumMessageHelper.limitMessages(displayedMessages,
            maxMessages: maxMessages,
            slotMaxMessages: messageLimits[slot.size]);
    final isAboveLimit = displayedMessages.length > limitedMessages.length;
    final messageTiles = limitedMessages
        .map((msg) => ListTile(
            title: Text(msg.label, textAlign: TextAlign.justify),
            leading: Column(
                children: iconCollection
                    .findIcons(msg)
                    .map((ico) => ico.icon)
                    .toList())))
        .toList();
    final header = BubblegumMessageBarSlot(
        slot: slot,
        showBadgesWhenEmpty: false,
        messages: messages,
        iconCollection: iconCollection);
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

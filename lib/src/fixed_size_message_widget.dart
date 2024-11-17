import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'message_bar_slot.dart';
import 'message_helper.dart';
import 'message_slot_options.dart';
import 'message_slot_theme.dart';

class BubblegumFixedSizeMessageWidget extends StatelessWidget {
  const BubblegumFixedSizeMessageWidget({
    super.key,
    required this.messages,
    required this.slot,
    required this.maxMessages,
    required this.options,
  });

  final List<CopperframeMessage> messages;
  final CopperframeSlotBase slot;
  final int maxMessages;
  final BubblegumMessageSlotOptions options;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final List<CopperframeMessage> displayedMessages =
        options.groupMessagesByLevel
            ? BubblegumMessageHelper.groupMessages(messages)
            : messages;
    List<CopperframeMessage> limitedMessages =
        BubblegumMessageHelper.limitMessages(displayedMessages,
            maxMessages: maxMessages,
            slotMaxMessages: options.messageLimits[slot.size]);
    final isAboveLimit = displayedMessages.length > limitedMessages.length;
    final messageTiles = limitedMessages
        .map((msg) => Semantics(
            button: options.hasTap(msg),
            onTapHint: options.onMaybeTapHint(msg),
            onLongPressHint: options.onMaybeLongPressHint(msg),
            child: ListTile(
                title: Text(msg.label, textAlign: TextAlign.justify),
                onTap: (options.hasTap(msg))
                    ? () => options.onMessageTap!(msg)
                    : null,
                onLongPress: (options.hasLongPress(msg))
                    ? () => options.onMessageLongPress!(msg)
                    : null,
                leading: Column(
                    children: options.iconCollection
                        .findIcons(msg)
                        .map((ico) => ico.icon)
                        .toList()))))
        .toList();
    final header = BubblegumMessageBarSlot(
        slot: slot, messages: messages, iconCollection: options.iconCollection);
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

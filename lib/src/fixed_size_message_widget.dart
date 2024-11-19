import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'message_bar_slot.dart';
import 'message_helper.dart';
import 'message_slot_options.dart';
import 'message_slot_theme.dart';

/// A stateless widget representing a fixed size message widget in the Bubblegum UI framework.
///
/// This widget displays a list of messages, grouped and limited based on the given options.
/// It includes a header, message tiles, and an indicator if more messages are available.
class BubblegumFixedSizeMessageWidget extends StatelessWidget {
  /// Creates an instance of [BubblegumFixedSizeMessageWidget].
  ///
  /// The [messages], [slot], [maxMessages], and [options] parameters are required.
  const BubblegumFixedSizeMessageWidget({
    super.key,
    required this.messages,
    required this.slot,
    required this.maxMessages,
    required this.options,
  });

  /// The list of messages to be displayed.
  ///
  /// The messages can be grouped or limited based on the [options] provided.
  final List<CopperframeMessage> messages;

  /// The slot associated with this message widget.
  ///
  /// This provides information about the slot, such as its size, that can affect the display.
  final CopperframeSlotBase slot;

  /// The maximum number of messages to display.
  ///
  /// This value is used to limit the number of messages shown in the widget.
  final int maxMessages;

  /// Options to customize the appearance and behavior of the message widget.
  ///
  /// These options determine how messages are grouped, whether they can be tapped, and more.
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
        slot: slot, messages: messages, options: options);
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

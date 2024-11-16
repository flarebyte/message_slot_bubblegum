import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/src/message_bar_slot.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'fixed_size_message_widget.dart';
import 'icon_collection.dart';
import 'message_callback.dart';
import 'message_slot_theme.dart';

class BubblegumMessageSlot extends StatelessWidget {
  final CopperframeSlotBase slot;
  final List<CopperframeMessage> messages;
  final Map<String, int> messageLimits; // Configure message count per size.
  final bool groupMessagesByLevel;
  final BubblegumIconCollection iconCollection;
  final OnMessageAction? onMessageTap;
  final OnMessageAction? onMessageLongPress;

  const BubblegumMessageSlot(
      {super.key,
      required this.slot,
      required this.messages,
      required this.iconCollection,
      this.messageLimits = const {
        'bar': 0,
        'small': 2,
        'medium': 5,
        'large': 8,
      },
      this.groupMessagesByLevel = false,
      this.onMessageTap,
      this.onMessageLongPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildDecorationByProminence(context),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: _buildSlotContent(context),
    );
  }

  BoxDecoration _buildDecorationByProminence(BuildContext context) {
    final themeData = Theme.of(context);

    switch (slot.prominence) {
      case 'low':
        return BubblegumMessageSlotTheme.getSlotBoxDecoration(
            themeData: themeData, shirtSize: TShirtSize.small);
      case 'medium':
        return BubblegumMessageSlotTheme.getSlotBoxDecoration(
            themeData: themeData, shirtSize: TShirtSize.medium);
      case 'high':
        return BubblegumMessageSlotTheme.getSlotBoxDecoration(
            themeData: themeData, shirtSize: TShirtSize.large);
      default:
        return BubblegumMessageSlotTheme.getSlotBoxDecoration(
            themeData: themeData, shirtSize: TShirtSize.small);
    }
  }

  Widget _buildSlotContent(BuildContext context) {
    switch (slot.size) {
      case 'bar':
        return BubblegumMessageBarSlot(
            slot: slot, messages: messages, iconCollection: iconCollection);
      case 'small':
        return BubblegumFixedSizeMessageWidget(
            groupMessagesByLevel: groupMessagesByLevel,
            messages: messages,
            iconCollection: iconCollection,
            messageLimits: messageLimits,
            slot: slot,
            maxMessages: 2,
            onMessageTap: onMessageTap,
            onMessageLongPress: onMessageLongPress);
      case 'medium':
        return BubblegumFixedSizeMessageWidget(
            groupMessagesByLevel: groupMessagesByLevel,
            messages: messages,
            iconCollection: iconCollection,
            messageLimits: messageLimits,
            slot: slot,
            maxMessages: 5,
            onMessageTap: onMessageTap,
            onMessageLongPress: onMessageLongPress);
      case 'large':
        return BubblegumFixedSizeMessageWidget(
            groupMessagesByLevel: groupMessagesByLevel,
            messages: messages,
            iconCollection: iconCollection,
            messageLimits: messageLimits,
            slot: slot,
            maxMessages: 8,
            onMessageTap: onMessageTap,
            onMessageLongPress: onMessageLongPress);
      default:
        return BubblegumMessageBarSlot(
            slot: slot, messages: messages, iconCollection: iconCollection);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/src/message_bar_slot.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'fixed_size_message_widget.dart';

import 'message_slot_options.dart';
import 'message_slot_theme.dart';

class BubblegumMessageSlot extends StatelessWidget {
  final CopperframeSlotBase slot;
  final List<CopperframeMessage> messages;
  final BubblegumMessageSlotOptions options;

  const BubblegumMessageSlot({
    super.key,
    required this.slot,
    required this.messages,
    required this.options,
  });

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
            slot: slot,
            messages: messages,
            iconCollection: options.iconCollection);
      case 'small':
        return BubblegumFixedSizeMessageWidget(
          messages: messages,
          slot: slot,
          maxMessages: 2,
          options: options,
        );
      case 'medium':
        return BubblegumFixedSizeMessageWidget(
          messages: messages,
          slot: slot,
          maxMessages: 5,
          options: options,
        );
      case 'large':
        return BubblegumFixedSizeMessageWidget(
          messages: messages,
          slot: slot,
          maxMessages: 8,
          options: options,
        );
      default:
        return BubblegumMessageBarSlot(
            slot: slot,
            messages: messages,
            iconCollection: options.iconCollection);
    }
  }
}

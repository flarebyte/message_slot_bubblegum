import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import '../message_slot_bubblegum.dart';
import 'message_badge_widget.dart';

/// A stateless widget representing a message bar slot in the Bubblegum UI framework.
///
/// This widget takes in a slot, a list of messages, and options to customize its appearance.
/// It displays the slot's title and description, along with a badge when there are messages.
class BubblegumMessageBarSlot extends StatelessWidget {
  /// Creates an instance of [BubblegumMessageBarSlot].
  ///
  /// The [slot], [messages], and [options] parameters are required.
  const BubblegumMessageBarSlot({
    super.key,
    required this.slot,
    required this.messages,
    required this.options,
  });

  /// The slot associated with this message bar.
  ///
  /// This provides information like the title and description of the slot,
  /// which are displayed in the UI.
  final CopperframeSlotBase slot;

  /// The list of messages to be displayed in this slot.
  ///
  /// If the list is not empty, a badge is shown to indicate the number of messages.
  final List<CopperframeMessage> messages;

  /// Options to customize the appearance and behavior of the message slot.
  ///
  /// These options define how the message bar should look and behave when there
  /// are messages to display.
  final BubblegumMessageSlotOptions options;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Tooltip(
          message: slot.description,
          child: Text(
            slot.title.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Spacer(),
        const SizedBox(width: 8),
        if (messages.isNotEmpty)
          BubblegumLevelBadgeWidget(messages: messages, options: options),
      ],
    );
  }
}

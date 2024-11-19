import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

import '../message_slot_bubblegum.dart';
import 'message_helper.dart';

/// A widget that displays a badge indicating the number of messages with a
/// visual representation based on the highest level of the messages.
///
/// The [BubblegumLevelBadgeWidget] takes a list of [CopperframeMessage] and an
/// [BubblegumMessageSlotOptions] object to determine the icon, label, and appearance
/// of the badge.
class BubblegumLevelBadgeWidget extends StatelessWidget {
  /// Creates an instance of [BubblegumLevelBadgeWidget].
  ///
  /// The [messages] parameter must not be null and contains the list of messages
  /// that will be represented by this widget.
  /// The [options] parameter must not be null and defines the visual options for
  /// the badge, including icons and labels.
  const BubblegumLevelBadgeWidget({
    super.key,
    required this.messages,
    required this.options,
  });

  /// The list of messages to be displayed as part of the badge.
  ///
  /// This list is used to determine the badge count and the visual appearance
  /// based on the highest level of messages present.
  final List<CopperframeMessage> messages;

  /// Options that define the behavior and visual appearance of the badge.
  ///
  /// The [options] is used to find the appropriate label and icon color for
  /// the highest level message.
  final BubblegumMessageSlotOptions options;

  @override
  Widget build(BuildContext context) {
    // Get the highest level of the messages to determine the visual representation.
    final highestLevel = BubblegumMessageHelper.getHighestLevel(messages);

    // If there are no messages, return an empty widget.
    if (messages.isEmpty) {
      return const SizedBox.shrink();
    }

    // Returns a badge with the count of messages, and an icon whose color and label
    // are based on the highest level of messages.
    return Badge.count(
      count: messages.length,
      child: Icon(
        Icons.notifications,
        semanticLabel: options.messageLabelForLevel(highestLevel),
        color: options.iconCollection
            .findIconByKeyOrDefault(highestLevel.name)
            .icon
            .color,
      ),
    );
  }
}

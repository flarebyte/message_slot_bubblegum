import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/src/message_bar_slot.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'fixed_size_message_widget.dart';

import 'message_slot_options.dart';
import 'message_slot_theme.dart';

/// A stateless widget representing a message slot in the Bubblegum UI framework.
///
/// This widget determines how a list of messages is displayed based on the given slot size and prominence.
/// It supports multiple slot sizes (bar, small, medium, large), each with its own layout and design.
class BubblegumMessageSlot extends StatelessWidget {
  /// The slot associated with this message slot widget.
  ///
  /// This provides information such as size and prominence, which determine how the messages will be displayed.
  final CopperframeSlotBase slot;

  /// The list of messages to be displayed in this slot.
  ///
  /// The way messages are displayed depends on the slot's size and the given options.
  final List<CopperframeMessage> messages;

  /// Options to customize the appearance and behavior of the message slot.
  ///
  /// These options define how messages are styled, grouped, and interacted with within the slot.
  final BubblegumMessageSlotOptions options;

  /// Creates an instance of [BubblegumMessageSlot].
  ///
  /// The [slot], [messages], and [options] parameters are required.
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

  /// Builds the decoration for the slot based on its prominence level.
  ///
  /// The prominence can be 'low', 'medium', or 'high', which determines the decoration style.
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

  /// Builds the content of the slot based on its size.
  ///
  /// The size can be 'bar', 'small', 'medium', or 'large', and determines which widget is used to display the messages.
  Widget _buildSlotContent(BuildContext context) {
    switch (slot.size) {
      case 'bar':
        return BubblegumMessageBarSlot(
          slot: slot,
          messages: messages,
          options: options,
        );
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
          options: options,
        );
    }
  }
}

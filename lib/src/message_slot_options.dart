import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

import '../message_slot_bubblegum.dart';
import 'message_callback.dart';

/// Represents configuration options for a Bubblegum message slot.
class BubblegumMessageSlotOptions {
  final Map<String, int> messageLimits;
  final bool groupMessagesByLevel;
  final BubblegumIconCollection iconCollection;
  final OnMessageAction? onMessageTap;
  final OnMessageAction? onMessageLongPress;
  final String? onTapHint;
  final String? onLongPressHint;
  final String? messageLabel;

  const BubblegumMessageSlotOptions({
    required this.messageLimits,
    required this.groupMessagesByLevel,
    required this.iconCollection,
    this.onMessageTap,
    this.onMessageLongPress,
    this.onTapHint,
    this.onLongPressHint,
    this.messageLabel,
  });

  bool hasTap(CopperframeMessage message) =>
      onMessageTap != null &&
      message.flags != null &&
      message.flags!.contains('onTap');

  bool hasLongPress(CopperframeMessage message) =>
      onMessageLongPress != null &&
      message.flags != null &&
      message.flags!.contains('onLongPress');

  String? onMaybeTapHint(CopperframeMessage message) =>
      hasTap(message) ? onTapHint : null;

  String? onMaybeLongPressHint(CopperframeMessage message) =>
      hasLongPress(message) ? onLongPressHint : null;
}

final BubblegumIconInfo _placeholder = BubblegumIconInfo(
    key: 'placeholder', icon: Icon(Icons.info, color: Colors.grey.shade100));

/// A builder class for constructing instances of `BubblegumMessageSlotOptions`
/// using a fluent API.
class BubblegumMessageSlotOptsBuilder {
  Map<String, int> _messageLimits = const {
    'bar': 0,
    'small': 2,
    'medium': 5,
    'large': 8,
  };
  bool _groupMessagesByLevel = false;
  BubblegumIconCollection _iconCollection = BubblegumIconCollection(
      defaultContent: _placeholder,
      icons: [_placeholder],
      maxIcons: 2,
      priorityKeys: []);
  OnMessageAction? _onMessageTap;
  OnMessageAction? _onMessageLongPress;
  String? _onTapHint;
  String? _onLongPressHint;
  String? _messageLabel;

  /// Sets the message limits for different levels.
  ///
  /// [limits] is a map where keys are message levels, and values are the
  /// maximum allowed messages for that level.
  BubblegumMessageSlotOptsBuilder setMessageLimits(Map<String, int> limits) {
    _messageLimits = limits;
    return this;
  }

  /// Specifies whether messages should be grouped by level.
  ///
  /// [group] indicates whether grouping is enabled.
  BubblegumMessageSlotOptsBuilder setGroupMessagesByLevel(bool group) {
    _groupMessagesByLevel = group;
    return this;
  }

  /// Assigns a collection of icons for the message slot.
  ///
  /// [icons] is a map where keys represent icon names, and values are their
  /// associated resources (e.g., URLs or asset paths).
  BubblegumMessageSlotOptsBuilder setIconCollection(
      BubblegumIconCollection icons) {
    _iconCollection = icons;
    return this;
  }

  /// Sets a callback for when a message is tapped.
  ///
  /// [callback] is invoked with the ID of the tapped message.
  BubblegumMessageSlotOptsBuilder setOnMessageTap(OnMessageAction? callback) {
    _onMessageTap = callback;
    return this;
  }

  /// Sets a callback for when a message is long-pressed.
  ///
  /// [callback] is invoked with the ID of the long-pressed message.
  BubblegumMessageSlotOptsBuilder setOnMessageLongPress(
      OnMessageAction? callback) {
    _onMessageLongPress = callback;
    return this;
  }

  /// Sets a hint describing the action for tapping a message.
  ///
  /// [hint] is a user-readable string explaining the tap action.
  BubblegumMessageSlotOptsBuilder setOnTapHint(String? hint) {
    _onTapHint = hint;
    return this;
  }

  /// Sets a hint describing the action for long-pressing a message.
  ///
  /// [hint] is a user-readable string explaining the long-press action.
  BubblegumMessageSlotOptsBuilder setOnLongPressHint(String? hint) {
    _onLongPressHint = hint;
    return this;
  }

  /// Sets a label for the message slot.
  ///
  /// [label] is a descriptive label for the message slot, typically for
  /// accessibility or UI purposes.
  BubblegumMessageSlotOptsBuilder setMessageLabel(String? label) {
    _messageLabel = label;
    return this;
  }

  /// Constructs and returns a new instance of `BubblegumMessageSlotOptions`
  /// with the current builder configuration.
  BubblegumMessageSlotOptions build() {
    return BubblegumMessageSlotOptions(
      messageLimits: _messageLimits,
      groupMessagesByLevel: _groupMessagesByLevel,
      iconCollection: _iconCollection,
      onMessageTap: _onMessageTap,
      onMessageLongPress: _onMessageLongPress,
      onTapHint: _onTapHint,
      onLongPressHint: _onLongPressHint,
      messageLabel: _messageLabel,
    );
  }
}

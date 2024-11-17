import '../message_slot_bubblegum.dart';
import 'message_callback.dart';

class BubblegumMessageSlotOptions {
  final Map<String, int> messageLimits;
  final bool groupMessagesByLevel;
  final BubblegumIconCollection iconCollection;
  final OnMessageAction? onMessageTap;
  final OnMessageAction? onMessageLongPress;
  final String? onTapHint;
  final String? onLongPressHint;
  final String? messageLabel;

  BubblegumMessageSlotOptions(
      this.messageLimits,
      this.groupMessagesByLevel,
      this.iconCollection,
      this.onMessageTap,
      this.onMessageLongPress,
      this.onTapHint,
      this.onLongPressHint,
      this.messageLabel);
}

class BubblegumMessageSlotOptsBuilder {}

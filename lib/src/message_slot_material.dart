import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/src/bubblegum_message_widget.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'message_helper.dart';
import 'message_slot_theme.dart';

class BubblegumMessageSlot extends StatelessWidget {
  final CopperframeSlotBase slot;
  final List<CopperframeMessage> messages;
  final bool showBadgesWhenEmpty;
  final Map<String, int> messageLimits; // Configure message count per size.
  final bool groupMessagesByLevel;

  const BubblegumMessageSlot({
    Key? key,
    required this.slot,
    required this.messages,
    this.showBadgesWhenEmpty = true,
    this.messageLimits = const {
      'bar': 0,
      'small': 2,
      'medium': 5,
      'large': -1, // Unlimited
    },
    this.groupMessagesByLevel = false,
  }) : super(key: key);

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
        return BoxDecoration(
          border: Border.all(
              width: 1.0,
              color: BubblegumMessageSlotTheme.colorOfSlot(themeData)),
          borderRadius: BorderRadius.circular(12),
        );
      case 'medium':
        return BoxDecoration(
          border: Border.all(
              width: 2.0,
              color: BubblegumMessageSlotTheme.colorOfSlot(themeData)),
          borderRadius: BorderRadius.circular(12),
        );
      case 'high':
        return BoxDecoration(
          border: Border.all(
              width: 4.0,
              color: BubblegumMessageSlotTheme.colorOfSlot(themeData)),
          borderRadius: BorderRadius.circular(12),
        );
      default:
        return BoxDecoration(
          border: Border.all(
            width: 1.0,
          ),
        );
    }
  }

  Widget _buildSlotContent(BuildContext context) {
    switch (slot.size) {
      case 'bar':
        return _buildBarSlot();
      case 'small':
        return _buildMessageList(2);
      case 'medium':
        return _buildMessageList(5);
      case 'large':
        return _buildScrollableMessageList();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBarSlot(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.info, color: Colors.blue),
        const SizedBox(width: 8),
        Text(slot.title, style: TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        Tooltip(message: slot.description, child: const Icon(Icons.help)),
        const SizedBox(width: 8),
        if (showBadgesWhenEmpty || messages.isNotEmpty) _buildBadges(context),
      ],
    );
  }

  Widget _buildBadges(BuildContext context) {
    return Row(
      children: [
        BubblegumMessageBadgeWidget(messages: messages, showBadgesWhenEmpty: showBadgesWhenEmpty, context: context, level: CopperframeMessageLevel.error),
        BubblegumMessageBadgeWidget(messages: messages, showBadgesWhenEmpty: showBadgesWhenEmpty, context: context, level: CopperframeMessageLevel.warning),
        BubblegumMessageBadgeWidget(messages: messages, showBadgesWhenEmpty: showBadgesWhenEmpty, context: context, level: CopperframeMessageLevel.info),
      ],
    );
  }

  Widget _buildMessageList(int maxMessages) {
    final List<CopperframeMessage> displayedMessages = groupMessagesByLevel
        ? BubblegumMessageHelper.groupMessages(messages)
        : messages;
    final int limit = messageLimits[slot.size] ?? maxMessages;
    final limitedMessages = displayedMessages.take(limit).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: limitedMessages
          .map((msg) => ListTile(
                title: Text(msg.label),
                leading: MessageLevelIcon(level: msg.level),
              ))
          .toList(),
    );
  }

  Widget _buildScrollableMessageList() {
    final List<CopperframeMessage> displayedMessages = groupMessagesByLevel
        ? BubblegumMessageHelper.groupMessages(messages)
        : messages;

    return Scrollbar(
      child: ListView.builder(
        itemCount: displayedMessages.length,
        itemBuilder: (context, index) {
          final msg = displayedMessages[index];
          return BubblegumMessageWidget(msg: msg);
        },
      ),
    );
  }
}

class BubblegumMessageBadgeWidget extends StatelessWidget {
  const BubblegumMessageBadgeWidget({
    super.key,
    required this.messages,
    required this.showBadgesWhenEmpty,
    required this.context,
    required this.level,
  });

  final List<CopperframeMessage> messages;
  final bool showBadgesWhenEmpty;
  final BuildContext context;
  final CopperframeMessageLevel level;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final int count =
        BubblegumMessageHelper.getMessageCountByLevel(messages, level);
    if (count == 0 && !showBadgesWhenEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: BubblegumMessageSlotTheme.getBadgeColor(themeData, level),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$count'),
    );
  }
}

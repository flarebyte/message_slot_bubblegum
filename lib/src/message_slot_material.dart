import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

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
      child: _buildSlotContent(context),
    );
  }

  BoxDecoration _buildDecorationByProminence(BuildContext context) {
    switch (slot.prominence) {
      case 'low':
        return BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            width: 1.0,
          ),
        );
      case 'medium':
        return BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            width: 2.0,
          ),
        );
      case 'high':
        return BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            width: 4.0,
          ),
        );
      default:
        return BoxDecoration(color: Theme.of(context).cardColor);
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

  Widget _buildBarSlot() {
    return Row(
      children: [
        Icon(Icons.info, color: Colors.blue),
        const SizedBox(width: 8),
        Text(slot.title, style: TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        Tooltip(message: slot.description, child: const Icon(Icons.help)),
        const SizedBox(width: 8),
        if (showBadgesWhenEmpty || _hasMessages()) _buildBadges(),
      ],
    );
  }

  Widget _buildBadges() {
    return Row(
      children: [
        _buildBadge(CopperframeMessageLevel.error),
        _buildBadge(CopperframeMessageLevel.warning),
        _buildBadge(CopperframeMessageLevel.info),
      ],
    );
  }

  Widget _buildBadge(CopperframeMessageLevel level) {
    final int count = _getMessageCountByLevel(level);
    if (count == 0 && !showBadgesWhenEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: _getBadgeColor(level),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$count'),
    );
  }

  Color _getBadgeColor(CopperframeMessageLevel level) {
    switch (level) {
      case CopperframeMessageLevel.error:
        return Colors.red.shade900;
      case CopperframeMessageLevel.warning:
        return Colors.orange.shade700;
      case CopperframeMessageLevel.info:
        return Colors.blue.shade900;
      default:
        return Colors.grey.shade800;
    }
  }

  int _getMessageCountByLevel(CopperframeMessageLevel level) {
    return messages.where((msg) => msg.level == level).length;
  }

  bool _hasMessages() {
    return messages.isNotEmpty;
  }

  Widget _buildMessageList(int maxMessages) {
    final List<CopperframeMessage> displayedMessages =
        groupMessagesByLevel ? _groupMessages() : messages;
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
    final List<CopperframeMessage> displayedMessages =
        groupMessagesByLevel ? _groupMessages() : messages;

    return Scrollbar(
      child: ListView.builder(
        itemCount: displayedMessages.length,
        itemBuilder: (context, index) {
          final msg = displayedMessages[index];
          return BuublegumMessageWidget(msg: msg);
        },
      ),
    );
  }

  List<CopperframeMessage> _groupMessages() {
    final errors = messages
        .where((msg) => msg.level == CopperframeMessageLevel.error)
        .toList();
    final warnings = messages
        .where((msg) => msg.level == CopperframeMessageLevel.warning)
        .toList();
    final info = messages
        .where((msg) => msg.level == CopperframeMessageLevel.info)
        .toList();
    return [...errors, ...warnings, ...info];
  }
}

class BuublegumMessageWidget extends StatelessWidget {
  const BuublegumMessageWidget({
    super.key,
    required this.msg,
  });

  final CopperframeMessage msg;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: BuublegumMessageWidget(msg: msg),
    );
  }
}

class MessageLevelIcon extends StatelessWidget {
  const MessageLevelIcon({
    super.key,
    required this.level,
  });

  final CopperframeMessageLevel level;

  @override
  Widget build(BuildContext context) {
    switch (level) {
      case CopperframeMessageLevel.error:
        return Icon(Icons.error, color: Colors.red.shade900);
      case CopperframeMessageLevel.warning:
        return Icon(Icons.warning, color: Colors.orange.shade700);
      case CopperframeMessageLevel.info:
        return Icon(Icons.info, color: Colors.blue.shade900);
      default:
        return Icon(Icons.message, color: Colors.grey.shade800);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

import 'message_helper.dart';
import 'message_widget.dart';

class BubblegumScrollableMessageWidget extends StatelessWidget {
  const BubblegumScrollableMessageWidget({
    super.key,
    required this.groupMessagesByLevel,
    required this.messages,
  });

  final bool groupMessagesByLevel;
  final List<CopperframeMessage> messages;

  @override
  Widget build(BuildContext context) {
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

import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

import 'message_helper.dart';
import 'message_slot_theme.dart';

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

class BubblegumLevelBadgeWidget extends StatelessWidget {
  const BubblegumLevelBadgeWidget({
    super.key,
    required this.messages,
    required this.showBadgesWhenEmpty,
    required this.context,
  });

  final List<CopperframeMessage> messages;
  final bool showBadgesWhenEmpty;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BubblegumMessageBadgeWidget(
            messages: messages,
            showBadgesWhenEmpty: showBadgesWhenEmpty,
            context: context,
            level: CopperframeMessageLevel.error),
        BubblegumMessageBadgeWidget(
            messages: messages,
            showBadgesWhenEmpty: showBadgesWhenEmpty,
            context: context,
            level: CopperframeMessageLevel.warning),
        BubblegumMessageBadgeWidget(
            messages: messages,
            showBadgesWhenEmpty: showBadgesWhenEmpty,
            context: context,
            level: CopperframeMessageLevel.info),
      ],
    );
  }
}

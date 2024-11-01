import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

class BubblegumMessageWidget extends StatelessWidget {
  const BubblegumMessageWidget({
    super.key,
    required this.msg,
  });

  final CopperframeMessage msg;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: BubblegumMessageWidget(msg: msg),
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

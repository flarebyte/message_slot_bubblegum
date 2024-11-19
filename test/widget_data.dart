import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

class InfoSlot extends CopperframeSlotBase {
  InfoSlot({required super.tags});
}

class WidgetData {
  static CopperframeMessage createCopperframeMessage(
          CopperframeMessageLevel level) =>
      CopperframeMessage(level: level, label: level.name, category: 'any');
  static final BubblegumIconInfo placeholder = BubblegumIconInfo(
      key: 'placeholder', icon: const Icon(Icons.info, color: Colors.grey));
  static final BubblegumIconInfo info = BubblegumIconInfo(
      key: 'info',
      icon: const Icon(
        Icons.info,
        color: Colors.blue,
        semanticLabel: 'info',
      ));
  static final BubblegumIconInfo warning = BubblegumIconInfo(
    key: 'warning',
    icon: const Icon(Icons.warning,
        color: Colors.orange, semanticLabel: 'warning'),
  );
  static final BubblegumIconInfo error = BubblegumIconInfo(
      key: 'error',
      icon: const Icon(Icons.error, color: Colors.red, semanticLabel: 'error'));
  static BubblegumIconCollection iconCollection = BubblegumIconCollection(
      defaultContent: placeholder,
      icons: [info, warning, error],
      maxIcons: 2,
      priorityKeys: [error.key, warning.key]);
  static InfoSlot createSlot({String? prominence, String? size}) {
    final mockSlot = InfoSlot(tags: ['main']);
    mockSlot.setValues(
        size: size ?? 'medium',
        prominence: prominence ?? 'low',
        title: 'Some title',
        description: 'This is a test slot description.');
    return mockSlot;
  }
}

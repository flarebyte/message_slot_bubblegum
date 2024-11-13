import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';

import 'circular_parameter_list.dart';
import 'multi_circular_iterator.dart';

class InfoSlot extends CopperframeSlotBase {
  InfoSlot({required super.tags});
}

class IterationData {
  late CircularParameterList slotMessages;
  late CircularParameterList prominence;
  late CircularParameterList size;
  late MultiCircularIterator mainCircularIterator;
  IterationData() {
    slotMessages = CircularParameterList<List<CopperframeMessage>>(
            label: '(1) Long', value: [MessageRepo.longInfo])
        .addParameter(
            '(2)', [MessageRepo.error, MessageRepo.info]).addParameter('(3)', [
      MessageRepo.error,
      MessageRepo.warning,
      MessageRepo.info
    ]).addParameter('(4)', [
      MessageRepo.otherError,
      MessageRepo.error,
      MessageRepo.warning,
      MessageRepo.info
    ]).addParameter('(6)', [
      MessageRepo.info,
      MessageRepo.warning,
      MessageRepo.info,
      MessageRepo.warning,
      MessageRepo.info,
      MessageRepo.warning,
    ]);
    prominence = CircularParameterList<String>(label: 'Low', value: 'low')
        .addParameter('Medium', 'medium')
        .addParameter('High', 'high');
    size = CircularParameterList<String>(label: 'Small', value: 'small')
        .addParameter('Medium', 'medium')
        .addParameter('Large', 'large')
        .addParameter('Bar', 'bar');
    mainCircularIterator =
        MultiCircularIterator([prominence, size, slotMessages]);
  }
}

class MessageRepo {
  static final info = CopperframeMessage(
      label: 'Info Lorem ipsum dolor sit amet, 😊 consectetur adipiscing elit.',
      level: CopperframeMessageLevel.info,
      category: 'privacy');
  static final longInfo = CopperframeMessage(
      label:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus tincidunt massa sem, et pulvinar dolor sollicitudin vitae. Suspendisse porta nunc leo, eu sagittis tellus facilisis vitae. Integer placerat hendrerit ipsum, ac ornare justo blandit vel. Vivamus finibus tortor diam, in volutpat nibh semper vel. Proin mi ex, blandit rhoncus sodales',
      level: CopperframeMessageLevel.info,
      category: 'privacy');
  static final veryLongInfo = CopperframeMessage(
      label:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin non lorem sit amet tellus semper vestibulum. Cras sit amet purus aliquam lacus finibus fringilla. Donec nulla odio, gravida quis eros ac, consectetur feugiat est. Sed et mauris vel metus lacinia ullamcorper. Cras bibendum nisl semper sem vehicula dictum. Nam et felis risus. Suspendisse iaculis lacus nec finibus fermentum. Ut tempor faucibus augue at facilisis. Duis id facilisis augue. Etiam tellus purus, scelerisque vitae posuere ac, pretium ac nisl. Quisque a congue mi, in hendrerit ipsum. Duis sed fermentum metus. Phasellus tempor eu ligula ut laoreet. Fusce varius in massa sit.',
      level: CopperframeMessageLevel.info,
      category: 'privacy');
  static final warning = CopperframeMessage(
      label:
          'Warning Lorem ipsum dolor 😈 sit amet, consectetur adipiscing elit. Proin non lorem sit amet tellus semper vestibulum.',
      level: CopperframeMessageLevel.warning,
      category: 'validation');
  static final otherWarning = CopperframeMessage(
      label:
          'Other warning Cras sit amet purus aliquam lacus finibus fringilla. Donec nulla odio, gravida quis eros ac, consectetur feugiat est.',
      level: CopperframeMessageLevel.warning,
      category: 'validation');
  static final error = CopperframeMessage(
      label:
          'Some error Cras sit amet purus aliquam lacus finibus fringilla. Donec nulla odio, gravida quis eros ac, consectetur feugiat est.',
      level: CopperframeMessageLevel.error,
      category: 'server');
  static final otherError = CopperframeMessage(
      label:
          'Other error Cras sit amet purus aliquam lacus finibus fringilla. Donec nulla odio, gravida quis eros ac, consectetur feugiat est.',
      level: CopperframeMessageLevel.error,
      category: '');
}

class WidgetThemeData {
  late CircularParameterList<ThemeData> themeData;
  WidgetThemeData() {
    themeData = CircularParameterList(
        label: 'Purple',
        value: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ));
    themeData.addParameter(
        'Green',
        ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ));
    themeData.addParameter('Dark', ThemeData.dark(useMaterial3: true));
  }
}

class IconRepo {
  static final BubblegumIconInfo placeholder = BubblegumIconInfo(
      key: 'placeholder',
      icon: const Icon(Icons.info),
      color: Colors.grey.shade100);
  static final BubblegumIconInfo info = BubblegumIconInfo(
      key: 'info', icon: const Icon(Icons.info), color: Colors.blue.shade600);
  static final BubblegumIconInfo warning = BubblegumIconInfo(
      key: 'warning',
      icon: const Icon(Icons.warning),
      color: Colors.orange.shade600);
  static final BubblegumIconInfo error = BubblegumIconInfo(
      key: 'error', icon: const Icon(Icons.error), color: Colors.red.shade600);
  static final BubblegumIconInfo fix = BubblegumIconInfo(
      key: 'fix', icon: const Icon(Icons.info), color: Colors.purple.shade600);
  static final BubblegumIconInfo help = BubblegumIconInfo(
      key: 'help', icon: const Icon(Icons.help), color: Colors.blue.shade600);
  static BubblegumIconCollection iconCollection = BubblegumIconCollection(
      defaultContent: placeholder,
      icons: [info, warning, error, fix, help],
      maxIcons: 3,
      priorityKeys: [error.key, warning.key, info.key, fix.key]);
}

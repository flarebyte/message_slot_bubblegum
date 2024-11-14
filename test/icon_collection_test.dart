import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';

void main() {
  group('BubblegumIconCollection', () {
    final defaultIcon =
        BubblegumIconInfo(key: 'default', icon: const Icon(Icons.error));
    final icon1 = BubblegumIconInfo(key: 'icon1', icon: const Icon(Icons.star));
    final icon2 =
        BubblegumIconInfo(key: 'icon2', icon: const Icon(Icons.access_alarm));
    final icon3 =
        BubblegumIconInfo(key: 'icon3', icon: const Icon(Icons.accessibility));

    test('findIconByKey returns the correct icon', () {
      final collection = BubblegumIconCollection(
        icons: [icon1, icon2, icon3],
        maxIcons: 3,
        priorityKeys: [],
        defaultContent: defaultIcon,
      );

      expect(collection.findIconByKey('icon1'), equals(icon1));
      expect(collection.findIconByKey('icon2'), equals(icon2));
      expect(collection.findIconByKey('nonexistent'), isNull);
    });

    test('findIconByKeyOrDefault returns the correct icon or default', () {
      final collection = BubblegumIconCollection(
        icons: [icon1, icon2, icon3],
        maxIcons: 3,
        priorityKeys: [],
        defaultContent: defaultIcon,
      );

      expect(collection.findIconByKeyOrDefault('icon1'), equals(icon1));
      expect(collection.findIconByKeyOrDefault('nonexistent'),
          equals(defaultIcon));
    });

    test('findIcons respects maxIcons limit', () {
      final message = CopperframeMessage(
          label: 'Some message',
          level: CopperframeMessageLevel.info,
          category: 'general',
          flags: null);
      final collection = BubblegumIconCollection(
        icons: [icon1, icon2, icon3],
        maxIcons: 2,
        priorityKeys: [],
        defaultContent: defaultIcon,
      );

      final result = collection.findIcons(message);
      expect(result.length, lessThanOrEqualTo(2));
    });

    test('findIcons returns icons based on priorityKeys', () {
      final message = CopperframeMessage(
          label: 'Some message',
          level: CopperframeMessageLevel.info,
          category: 'general',
          flags: 'priority');
      final collection = BubblegumIconCollection(
        icons: [icon1, icon2, icon3],
        maxIcons: 3,
        priorityKeys: ['icon3', 'icon1'],
        defaultContent: defaultIcon,
      );

      final result = collection.findIcons(message);
      expect(result, contains(icon3));
      expect(result.first, equals(icon3));
    });
  });

  group('BubblegumPriorityKeyHelpers', () {
    test('iconsToKeys returns correct keys', () {
      final icons = [
        BubblegumIconInfo(key: 'icon1', icon: const Icon(Icons.star)),
        BubblegumIconInfo(key: 'icon2', icon: const Icon(Icons.access_alarm)),
      ];
      final keys = BubblegumPriorityKeyHelpers.iconsToKeys(icons);

      expect(keys, containsAll(['icon1', 'icon2']));
    });

    test('extractPrefix extracts prefix correctly', () {
      final result =
          BubblegumPriorityKeyHelpers.extractPrefix('prefix:value', ':');
      expect(result, equals('prefix'));
    });

    test('flagsToKeys splits flags correctly', () {
      final flags = 'flag1 flag2:extra';
      final keys =
          BubblegumPriorityKeyHelpers.flagsToKeys(flags, prefixSeparator: ':');

      expect(keys, containsAll(['flag1', 'flag2']));
      expect(keys, isNot(contains('extra')));
    });
  });
}

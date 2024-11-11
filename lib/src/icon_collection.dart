import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

class BubblegumIconInfo {
  final String key;
  final Icon icon;
  final Color? color;

  BubblegumIconInfo({required this.key, required this.icon, this.color});
}

class BubblegumIconCollection {
  final List<BubblegumIconInfo> icons;
  late Set<String> iconKeySet;
  final int maxIcons;
  final List<String> priorityKeys;
  late Set<String> priorityKeySet;
  final BubblegumIconInfo defaultContent;

  BubblegumIconCollection(
      {required this.icons,
      required this.maxIcons,
      required this.priorityKeys,
      required this.defaultContent}) {
    assert(maxIcons > 0);
    priorityKeySet = priorityKeys.toSet();
    iconKeySet = BubblegumPriorityKeyHelpers.iconsToKeys(icons);
  }

  BubblegumIconInfo? findIconByKey(String key) {
    return icons.firstWhere((icon) => icon.key == key);
  }

  List<BubblegumIconInfo> findIcons(CopperframeMessage message) {
    final Set<String> passedKeys =
        BubblegumPriorityKeyHelpers.messageToKeys(message);
    final availableKeys = iconKeySet.intersection(passedKeys);
    final List<String> givenPriorityKeys =
        priorityKeys.where((key) => availableKeys.contains(key)).toList();
    final remainingKeys =
        availableKeys.intersection(Set.from(givenPriorityKeys)).toList();
    final acceptableKeys =
        [...givenPriorityKeys, ...remainingKeys].take(maxIcons).toList();
    final results = acceptableKeys
        .map((key) => findIconByKey(key))
        .whereType<BubblegumIconInfo>()
        .toList();
    return results;
  }
}

class BubblegumPriorityKeyHelpers {
  static Set<String> iconsToKeys<C>(List<BubblegumIconInfo> items) {
    return items.map((item) => item.key).toSet();
  }

  static Set<String> messageToKeys<C>(CopperframeMessage message) {
    final Set<String> passedKeys = {message.level.name, message.category};
    if (message.flags != null) {
      passedKeys.addAll(BubblegumPriorityKeyHelpers.flagsToKeys(
          message.flags ?? '',
          prefixSeparator: ':'));
    }
    return passedKeys;
  }

  static String extractPrefix(String text, String prefixSeparator) =>
      text.contains(prefixSeparator)
          ? text.split(prefixSeparator)[0].trim()
          : text.trim();

  static Set<String> flagsToKeys<C>(String flags,
      {String separator = ' ', String? prefixSeparator}) {
    return flags
        .split(separator)
        .map((flag) => prefixSeparator == null
            ? flag.trim()
            : extractPrefix(flag, prefixSeparator))
        .toSet();
  }
}

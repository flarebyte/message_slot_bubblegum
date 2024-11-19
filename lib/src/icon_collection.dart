import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';

/// The `BubblegumIconInfo` class represents an icon with an associated key.
///
/// Fields:
/// - `key` (String): The unique key associated with the icon.
/// - `icon` (Icon): The icon represented as a Flutter `Icon` widget.
class BubblegumIconInfo {
  final String key;
  final Icon icon;

  BubblegumIconInfo({required this.key, required this.icon});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BubblegumIconInfo &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          icon == other.icon;

  @override
  int get hashCode => key.hashCode ^ icon.hashCode;

  @override
  String toString() {
    return 'BubblegumIconInfo{key: $key}';
  }
}

/// The `BubblegumIconCollection` class manages a collection of `BubblegumIconInfo` objects.
/// This collection can be filtered based on priority keys and a `CopperframeMessage` object.
///
/// Fields:
/// - `icons` (List<BubblegumIconInfo>): A list of available icons.
/// - `iconKeySet` (Set<String>): A set of keys from the available icons. Automatically generated during construction.
/// - `maxIcons` (int): The maximum number of icons to be returned when querying.
/// - `priorityKeys` (List<String>): A list of priority keys to determine the priority of icons.
/// - `priorityKeySet` (Set<String>): A set of priority keys, automatically generated during construction.
/// - `defaultContent` (BubblegumIconInfo): The default icon to return if no icon matches a given key.
///
/// Methods:
/// - `BubblegumIconCollection(...)`: Constructor for creating an instance of `BubblegumIconCollection`.
/// - `findIconByKey(String key)`: Finds an icon by its key. Returns `null` if no matching icon is found.
/// - `findIconByKeyOrDefault(String key)`: Finds an icon by its key. Returns the `defaultContent` if no matching icon is found.
/// - `findIcons(CopperframeMessage message)`: Finds a list of icons based on the message's keys and priority keys, up to a maximum specified by `maxIcons`.
class BubblegumIconCollection {
  final List<BubblegumIconInfo> icons;
  late Set<String> iconKeySet;
  final int maxIcons;
  final List<String> priorityKeys;
  late Set<String> priorityKeySet;
  final BubblegumIconInfo defaultContent;

  /// Constructor for `BubblegumIconCollection`.
  ///
  /// Parameters:
  /// - `icons` (List<BubblegumIconInfo>): The list of available icons.
  /// - `maxIcons` (int): The maximum number of icons that can be returned.
  /// - `priorityKeys` (List<String>): The list of keys that determine priority.
  /// - `defaultContent` (BubblegumIconInfo): The default icon to be used when no key matches.
  BubblegumIconCollection({
    required this.icons,
    required this.maxIcons,
    required this.priorityKeys,
    required this.defaultContent,
  }) {
    assert(maxIcons > 0);
    priorityKeySet = priorityKeys.toSet();
    iconKeySet = BubblegumPriorityKeyHelpers.iconsToKeys(icons);
  }

  bool hasIconWithKey(String key) {
    return iconKeySet.contains(key);
  }

  /// Finds an icon by its key or returns the default icon if not found.
  ///
  /// Parameters:
  /// - `key` (String): The key of the icon to be found.
  ///
  /// Returns:
  /// - `BubblegumIconInfo`: The matching icon or `defaultContent` if no match is found.
  BubblegumIconInfo findIconByKeyOrDefault(String key) {
    return hasIconWithKey(key)
        ? icons.firstWhere((icon) => icon.key == key)
        : defaultContent;
  }

  /// Finds icons based on the given `CopperframeMessage`.
  /// Filters the icons based on priority keys and the passed message keys.
  ///
  /// Parameters:
  /// - `message` (CopperframeMessage): The message that contains keys to find matching icons.
  ///
  /// Returns:
  /// - `List<BubblegumIconInfo>`: A list of icons matching the message keys, up to the maximum defined by `maxIcons`.
  List<BubblegumIconInfo> findIcons(CopperframeMessage message) {
    final Set<String> passedKeys =
        BubblegumPriorityKeyHelpers.messageToKeys(message);
    final availableKeys = iconKeySet.intersection(passedKeys);
    final List<String> givenPriorityKeys =
        priorityKeys.where((key) => availableKeys.contains(key)).toList();
    final remainingKeys =
        availableKeys.difference(Set.from(givenPriorityKeys)).toList();
    final acceptableKeys =
        [...givenPriorityKeys, ...remainingKeys].take(maxIcons).toList();
    final results =
        acceptableKeys.map((key) => findIconByKeyOrDefault(key)).toList();
    return results;
  }
}

/// The `BubblegumPriorityKeyHelpers` class provides utility functions to work with keys and flags for icons and messages.
///
/// Static Methods:
/// - `iconsToKeys(List<BubblegumIconInfo> items)`: Converts a list of icons into a set of keys.
/// - `messageToKeys(CopperframeMessage message)`: Extracts keys from a `CopperframeMessage` object.
/// - `extractPrefix(String text, String prefixSeparator)`: Extracts the prefix of a text given a prefix separator.
/// - `flagsToKeys(String flags, {String separator = ' ', String? prefixSeparator})`: Converts flags into a set of keys, with optional separators.
class BubblegumPriorityKeyHelpers {
  /// Converts a list of icons into a set of keys.
  ///
  /// Parameters:
  /// - `items` (List<BubblegumIconInfo>): The list of icons to convert.
  ///
  /// Returns:
  /// - `Set<String>`: A set of keys from the given list of icons.
  static Set<String> iconsToKeys<C>(List<BubblegumIconInfo> items) {
    return items.map((item) => item.key).toSet();
  }

  /// Extracts keys from a `CopperframeMessage` object.
  ///
  /// Parameters:
  /// - `message` (CopperframeMessage): The message to extract keys from.
  ///
  /// Returns:
  /// - `Set<String>`: A set of keys from the message, including the message level and category, as well as flags if present.
  static Set<String> messageToKeys<C>(CopperframeMessage message) {
    final Set<String> passedKeys = {message.level.name, message.category};
    if (message.flags != null) {
      passedKeys.addAll(BubblegumPriorityKeyHelpers.flagsToKeys(
          message.flags ?? '',
          prefixSeparator: ':'));
    }
    return passedKeys;
  }

  /// Extracts the prefix from a text given a prefix separator.
  ///
  /// Parameters:
  /// - `text` (String): The text to extract the prefix from.
  /// - `prefixSeparator` (String): The separator used to split the prefix.
  ///
  /// Returns:
  /// - `String`: The prefix if found, otherwise the original text.
  static String extractPrefix(String text, String prefixSeparator) =>
      text.contains(prefixSeparator)
          ? text.split(prefixSeparator)[0].trim()
          : text.trim();

  /// Converts flags into a set of keys, with optional separators.
  ///
  /// Parameters:
  /// - `flags` (String): The flags to be split into keys.
  /// - `separator` (String, optional): The separator used to split the flags. Default is a space (' ').
  /// - `prefixSeparator` (String, optional): A prefix separator used to extract prefixes.
  ///
  /// Returns:
  /// - `Set<String>`: A set of keys derived from the flags.
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

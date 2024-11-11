class BubblegumContentItem<C> {
  final String key;
  final C value;

  BubblegumContentItem(this.key, this.value);
}

class BubblegumContentMinistore<C> {
  final List<BubblegumContentItem<C>> items;
  final int maxItems;
  final List<String> priorityKeys;
  final C? defaultContent;

  BubblegumContentMinistore(
      {required this.items,
      required this.maxItems,
      required this.priorityKeys,
      this.defaultContent});

  findContentByFlags(String flags) {}
}

class BubblegumPriorityKeyHelpers {
  static Set<String> contentKeys<C>(List<BubblegumContentItem<C>> items) {
    return items.map((item) => item.key).toSet();
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

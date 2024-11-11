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
}

class BubblegumPriorityKeyHelpers {
  static Set<String> contentKeys<C>(List<BubblegumContentItem<C>> items) {
    return items.map((item) => item.key).toSet();
  }
}

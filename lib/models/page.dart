class Page<T> {
  final List<T> items;
  final String? nextCursor;

  Page({required this.items, this.nextCursor});

  bool get hasMore => nextCursor != null;
}

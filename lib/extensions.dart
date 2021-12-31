extension ZipAlong<T, R> on Iterable<T> {
  /// Returns a list of each two adjacent elements mapped by [mapping].
  /// The return list is empty if the collection contains less than two elements.
  List<R> zipWithNext(R Function(T prev, T next) mapping) {
    final result = <R>[];
    final it = iterator;
    T? prev;
    while (it.moveNext()) {
      if (prev != null) {
        result.add(mapping(prev, it.current));
      }
      prev = it.current;
    }

    return result;
  }
}

extension Filter<T> on Iterable<T> {
  /// Filters out the elements that do not satisfy the predicate [predicate].
  List<T> filter(bool Function(T value) predicate) {
    final result = <T>[];
    for (var value in this) {
      if (predicate(value)) {
        result.add(value);
      }
    }
    return result;
  }
}

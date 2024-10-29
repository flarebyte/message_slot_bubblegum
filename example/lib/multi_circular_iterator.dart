import 'circular_parameter_list.dart';

class MultiCircularIterator extends CircularIteratorBase {
  /// Manages multiple [CircularIteratorBase] instances and iterates through them in a combined manner.
  /// The iteration goes through every possible combination of the underlying iterators.
  int _index = 0;
  List<CircularIteratorBase> iterators;

  /// Creates a new instance of [MultiCircularIterator] with a list of [CircularIteratorBase] iterators.
  MultiCircularIterator(this.iterators);

  /// Returns the current combined index of the iteration.
  /// The index starts at `0` and increments as [next()] is called.
  @override
  int currentIndex() {
    return _index;
  }

  /// Returns `true` if the current index is at the beginning of the iteration.
  @override
  bool isFirst() {
    return _index == 0;
  }

  /// Returns the total length of all iterators combined.
  /// The length is the product of the lengths of all underlying iterators.
  @override
  int length() {
    return iterators.map((i) => i.length()).reduce((a, b) => a * b);
  }

  /// Moves to the next combination of iterators.
  /// If it reaches the end, it cycles back to the first combination and resets all iterators.
  @override
  void next() {
    _index++;
    _resetIfOutsideLengthRange();
    bool wasFirst = true;
    for (final (index, iterator) in iterators.indexed) {
      if (index == 0 || wasFirst) {
        iterator.next();
      }
      wasFirst = iterator.isFirst();
    }
  }

  /// Resets the current index and all underlying iterators.
  @override
  void reset() {
    _index = 0;
    for (var iterator in iterators) {
      iterator.reset();
    }
  }

  /// Resets the index if it is outside the length range.
  void _resetIfOutsideLengthRange() {
    if (_index >= length()) {
      reset();
    }
  }
}

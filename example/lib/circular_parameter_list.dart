class CircularParameter<T> {
  final String label;
  final T value;

  CircularParameter({required this.label, required this.value});
}

abstract class CircularIteratorBase {
  void next();
  int length();
  void reset();
  int currentIndex();
  bool isFirst();
}

class CircularParameterList<T> extends CircularIteratorBase {
  final List<CircularParameter<T>> parameters = [];
  int _index = 0;

  CircularParameterList({required String label, required T value}) {
    addParameter(label, value);
  }

  /// Moves to the next parameter. If it reaches the end, it cycles back to the first element
  /// and triggers the [onCycleRestart] callback if provided.
  @override
  void next() {
    _index = (_index + 1) % parameters.length;
  }

  /// Returns the current parameter as a [CircularParameter<T>].
  /// Returns `null` if the list is empty or the index is not set.
  CircularParameter<T> current() {
    return parameters[_index];
  }

  /// Resets the index to the first parameter in the list.
  /// Does nothing if the list is empty.
  @override
  void reset() {
    if (parameters.isNotEmpty) {
      _index = 0;
    }
  }

  /// Returns the total number of parameters in the list.
  @override
  int length() {
    return parameters.length;
  }

  /// Returns the current index, or `-1` if the index is null (e.g., iteration not started
  /// or list is empty).
  @override
  int currentIndex() {
    return _index;
  }

  @override
  bool isFirst() {
    return _index == 0;
  }

  /// Returns a copy of the list of parameters.
  List<CircularParameter<T>> toList() {
    return List<CircularParameter<T>>.from(parameters);
  }

  /// Adds a new [CircularParameter] to the list.
  addParameter(String label, T value) {
    parameters.add(CircularParameter(label: label, value: value));
    return this;
  }
}

class MultiCircularIterator extends CircularIteratorBase {
  int _index = 0;
  List<CircularIteratorBase> iterators;

  MultiCircularIterator(this.iterators);

  @override
  int currentIndex() {
    return _index;
  }

  @override
  bool isFirst() {
    return _index == 0;
  }

  @override
  int length() {
    return iterators.map((i) => i.length()).reduce((a, b) => a * b);
  }

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
  _resetIfOutsideLengthRange(){
    if (_index>=length()){
      reset();
    }
  }
  @override
  void reset() {
    _index = 0;
    for (var iterator in iterators) {
      iterator.reset();
    }
  }
}

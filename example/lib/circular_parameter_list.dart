class CircularParameter<T> {
  /// Represents a parameter with a label and a value of generic type [T].
  final String label;
  final T value;

  CircularParameter({required this.label, required this.value});
}

abstract class CircularIteratorBase {
  /// Moves to the next element in the list, cycling back to the start if at the end.
  void next();

  /// Returns the total number of elements in the list.
  int length();

  /// Resets the current index to the beginning of the list.
  void reset();

  /// Returns the current index of the iteration.
  int currentIndex();

  /// Returns true if the current element is the first in the list.
  bool isFirst();
}

class CircularParameterList<T> extends CircularIteratorBase {
  final List<CircularParameter<T>> parameters = [];
  int _index = 0;

  /// Creates a new instance of [CircularParameterList] with an initial parameter.
  /// The list is initialized with the given [label] and [value].
  CircularParameterList({required String label, required T value}) {
    addParameter(label, value);
  }

  /// Moves to the next parameter in the list.
  /// If it reaches the end of the list, it cycles back to the first element.
  @override
  void next() {
    _index = (_index + 1) % parameters.length;
  }

  /// Returns the current parameter as a [CircularParameter<T>].
  CircularParameter<T> current() {
    return parameters[_index];
  }

  /// Resets the index to the first parameter in the list.
  @override
  void reset() {
    _index = 0;
  }

  /// Returns the total number of parameters in the list.
  @override
  int length() {
    return parameters.length;
  }

  /// Returns the current index of the list.
  /// The index starts at `0` and increments circularly as [next()] is called.
  @override
  int currentIndex() {
    return _index;
  }

  /// Returns `true` if the current parameter is the first in the list.
  @override
  bool isFirst() {
    return _index == 0;
  }

  /// Returns a copy of the list of parameters.
  /// This allows access to the complete list without modifying the original.
  List<CircularParameter<T>> toList() {
    return List<CircularParameter<T>>.from(parameters);
  }

  /// Adds a new [CircularParameter] to the list.
  /// This method returns the instance of [CircularParameterList] to allow for method chaining.
  CircularParameterList<T> addParameter(String label, T value) {
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

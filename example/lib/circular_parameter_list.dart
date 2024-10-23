class CircularParameter<T> {
  final String label;
  final T value;

  CircularParameter({required this.label, required this.value});
}

class CircularParameterList<T> {
  final List<CircularParameter<T>> parameters = [];
  int _index = 0;
  final void Function()? onCycleRestart;

  CircularParameterList({this.onCycleRestart, required String label, required T value}){
   addParameter(label, value);
  }

  /// Moves to the next parameter. If it reaches the end, it cycles back to the first element
  /// and triggers the [onCycleRestart] callback if provided.
  void next() {
    _index =(_index + 1) % parameters.length;
    if (_index == 0 && onCycleRestart != null) {
      onCycleRestart!();
    }
  }

  /// Returns the current parameter as a [CircularParameter<T>].
  /// Returns `null` if the list is empty or the index is not set.
  CircularParameter<T> current() {
    return parameters[_index];
  }

  /// Resets the index to the first parameter in the list.
  /// Does nothing if the list is empty.
  void reset() {
    if (parameters.isNotEmpty) {
      _index = 0;
    }
  }

  /// Returns the total number of parameters in the list.
  int length() {
    return parameters.length;
  }

  /// Returns the current index, or `-1` if the index is null (e.g., iteration not started
  /// or list is empty).
  int currentIndex() {
    return _index;
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

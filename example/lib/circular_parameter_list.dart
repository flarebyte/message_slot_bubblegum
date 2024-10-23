class CircularParameterList<T> {
  final List<Map<String, T>> _parameters = [];
  int? _index;
  final void Function()? onCycleRestart;

  CircularParameterList({this.onCycleRestart});

  /// Moves to the next parameter. If it reaches the end, it cycles back to the first element
  /// and triggers the [onCycleRestart] callback if provided.
  void next() {
    if (_parameters.isEmpty) return;

    _index = (_index == null) ? 0 : (_index! + 1) % _parameters.length;
    if (_index == 0 && onCycleRestart != null) {
      onCycleRestart!();
    }
  }

  /// Returns the current parameter as a [Map<String, T>] where 'label' is the key for
  /// the label and 'value' is the key for the value. Returns `null` if the list is empty
  /// or if the index is not set.
  Map<String, T>? current() {
    if (_index == null || _parameters.isEmpty) return null;
    return _parameters[_index!];
  }

  /// Resets the index to the first parameter in the list.
  /// Does nothing if the list is empty.
  void reset() {
    if (_parameters.isNotEmpty) {
      _index = 0;
    }
  }

  /// Returns the total number of parameters in the list.
  int length() {
    return _parameters.length;
  }

  /// Returns the current index, or `-1` if the index is null (e.g., iteration not started
  /// or list is empty).
  int currentIndex() {
    return _index ?? -1;
  }

  /// Returns a copy of the list of parameters in the format of [List<Map<String, T>>].
  List<Map<String, T>> toList() {
    return List<Map<String, T>>.from(_parameters);
  }

  /// Adds a new parameter to the list.
  void addParameter(String label, T value) {
    _parameters.add({'label': label, 'value': value});
  }

  /// Removes a parameter by its label. Returns `true` if the parameter was found and removed,
  /// otherwise `false`.
  bool removeParameter(String label) {
    final index = _parameters.indexWhere((param) => param['label'] == label);
    if (index != -1) {
      _parameters.removeAt(index);
      if (_index != null && _index! >= _parameters.length) {
        _index = 0; // Reset index if it exceeds the list length
      }
      return true;
    }
    return false;
  }
}

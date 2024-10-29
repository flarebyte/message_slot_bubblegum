
import 'circular_parameter_list.dart';

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

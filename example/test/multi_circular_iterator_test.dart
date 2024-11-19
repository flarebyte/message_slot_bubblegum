import 'package:example/circular_parameter_list.dart';
import 'package:example/multi_circular_iterator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MultiCircularIterator iterates through all combinations correctly', () {
    final list1 = CircularParameterList(label: 'param1', value: 1)
      ..addParameter('param2', 2);
    final list2 = CircularParameterList(label: 'paramA', value: 'A')
      ..addParameter('paramB', 'B');
    final multiIterator = MultiCircularIterator([list1, list2]);

    expect(multiIterator.length(), 4);
    expect(multiIterator.currentIndex(), 0);

    multiIterator.next();
    expect(multiIterator.currentIndex(), 1);
    expect(list1.current().label, 'param2');
    expect(list2.current().label, 'paramA');

    multiIterator.next();
    expect(multiIterator.currentIndex(), 2);
    expect(list1.current().label, 'param1');
    expect(list2.current().label, 'paramB');

    multiIterator.next();
    expect(multiIterator.currentIndex(), 3);
    expect(list1.current().label, 'param2');
    expect(list2.current().label, 'paramB');

    multiIterator.next();
    expect(multiIterator.currentIndex(), 0);
    expect(list1.current().label, 'param1');
    expect(list2.current().label, 'paramA');
  });

  test('MultiCircularIterator resets correctly', () {
    final list1 = CircularParameterList(label: 'param1', value: 1)
      ..addParameter('param2', 2);
    final list2 = CircularParameterList(label: 'paramA', value: 'A')
      ..addParameter('paramB', 'B');
    final multiIterator = MultiCircularIterator([list1, list2]);

    multiIterator.next();
    multiIterator.next();
    multiIterator.reset();

    expect(multiIterator.currentIndex(), 0);
    expect(list1.current().label, 'param1');
    expect(list2.current().label, 'paramA');
  });

  test('MultiCircularIterator cycles back after reaching the end', () {
    final list1 = CircularParameterList(label: 'param1', value: 1)
      ..addParameter('param2', 2);
    final list2 = CircularParameterList(label: 'paramA', value: 'A')
      ..addParameter('paramB', 'B');
    final multiIterator = MultiCircularIterator([list1, list2]);

    for (int i = 0; i < 4; i++) {
      multiIterator.next();
    }

    expect(multiIterator.currentIndex(), 0);
    expect(list1.current().label, 'param1');
    expect(list2.current().label, 'paramA');
  });
}

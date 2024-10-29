import 'package:example/circular_parameter_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('addParameter adds parameters correctly', () {
    final list = CircularParameterList(label: 'param1', value: 1)
      ..addParameter('param2', 2);
    expect(list.length(), 2);
    expect(list.current().label, 'param1');
  });

  test('next cycles through parameters', () {
    final list = CircularParameterList(label: 'param1', value: 1)
      ..addParameter('param2', 2);
    list.next();
    expect(list.current().label, 'param2');
    list.next();
    expect(list.current().label, 'param1');
  });

  test('reset sets index to start', () {
    final list = CircularParameterList(label: 'param1', value: 1)
      ..addParameter('param2', 2);
    list.next();
    list.reset();
    expect(list.currentIndex(), 0);
    expect(list.current().label, 'param1');
  });

  test('currentIndex returns correct index', () {
    final list = CircularParameterList(label: 'param1', value: 1)
      ..addParameter('param2', 2);
    expect(list.currentIndex(), 0);
    list.next();
    expect(list.currentIndex(), 1);
  });

  test('isFirst returns true only for first parameter', () {
    final list = CircularParameterList(label: 'param1', value: 1)
      ..addParameter('param2', 2);
    expect(list.isFirst(), true);
    list.next();
    expect(list.isFirst(), false);
    list.next();
    expect(list.isFirst(), true);
  });

  test('toList returns a copy of parameters', () {
    final list = CircularParameterList(label: 'param1', value: 1)
      ..addParameter('param2', 2);
    final copiedList = list.toList();
    expect(copiedList.length, 2);
    expect(copiedList[0].label, 'param1');
    expect(copiedList[1].label, 'param2');
  });
}

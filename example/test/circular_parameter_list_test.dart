import 'package:example/circular_parameter_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CircularParameterList Tests', () {
    late CircularParameterList<String> circularList;

    setUp(() {
      // Initializes a new list before each test.
      circularList =
          CircularParameterList<String>(label: 'start', value: 'start');
    });

    test('Initial length should be 0', () {
      expect(circularList.length(), 0);
    });

    test('next() on an empty list should not crash', () {
      circularList.next();
      expect(circularList.current(), null); // No parameter in the list.
      expect(circularList.currentIndex(), -1); // Index should remain invalid.
    });

    test('Adding parameters should increase length', () {
      circularList.addParameter('Param1', 'Value1');
      circularList.addParameter('Param2', 'Value2');
      expect(circularList.length(), 2);
    });

    test('next() should iterate through the list', () {
      circularList.addParameter('Param1', 'Value1');
      circularList.addParameter('Param2', 'Value2');
      circularList.addParameter('Param3', 'Value3');

      // Initially no iteration done, so current should return null.
      expect(circularList.current(), null);

      // Move to first item
      circularList.next();
      expect(circularList.current().label, 'Param1');
      expect(circularList.current().value, 'Value1');

      // Move to second item
      circularList.next();
      expect(circularList.current().label, 'Param2');
      expect(circularList.current().value, 'Value2');

      // Move to third item
      circularList.next();
      expect(circularList.current().label, 'Param3');
      expect(circularList.current().value, 'Value3');

      // Move back to first item (circular)
      circularList.next();
      expect(circularList.current().label, 'Param1');
      expect(circularList.current().value, 'Value1');
    });

    test('reset() should set index back to 0', () {
      circularList.addParameter('Param1', 'Value1');
      circularList.addParameter('Param2', 'Value2');

      // Move through the list
      circularList.next(); // Now at Param1
      circularList.next(); // Now at Param2

      // Reset to the start
      circularList.reset();
      expect(circularList.current().label, 'Param1');
      expect(circularList.current().value, 'Value1');
    });

    test('onCycleRestart callback should trigger on cycling back to start', () {
      bool callbackTriggered = false;

      // Initialize the list with the callback
      circularList = CircularParameterList<String>(
        label: 'start',
        value: 'start',
        onCycleRestart: () => callbackTriggered = true,
      );

      circularList.addParameter('Param1', 'Value1');
      circularList.addParameter('Param2', 'Value2');

      // Move through the list
      circularList.next(); // Now at Param1
      circularList.next(); // Now at Param2

      // Moving to the next should trigger callback (wrap back to Param1)
      circularList.next();
      expect(callbackTriggered, isTrue);
    });

    test('currentIndex() should return -1 if no iteration has started', () {
      expect(circularList.currentIndex(),
          -1); // Index should be -1 if next() hasn't been called.
    });

    test('currentIndex() should return correct index during iteration', () {
      circularList.addParameter('Param1', 'Value1');
      circularList.addParameter('Param2', 'Value2');
      circularList.addParameter('Param3', 'Value3');

      circularList.next(); // Now at Param1
      expect(circularList.currentIndex(), 0);

      circularList.next(); // Now at Param2
      expect(circularList.currentIndex(), 1);

      circularList.next(); // Now at Param3
      expect(circularList.currentIndex(), 2);

      circularList.next(); // Wraps back to Param1
      expect(circularList.currentIndex(), 0);
    });

    test('toList() should return a copy of the list of parameters', () {
      circularList.addParameter('Param1', 'Value1');
      circularList.addParameter('Param2', 'Value2');

      final listCopy = circularList.toList();
      expect(listCopy.length, 2);
      expect(listCopy[0].label, 'Param1');
      expect(listCopy[0].value, 'Value1');
      expect(listCopy[1].label, 'Param2');
      expect(listCopy[1].value, 'Value2');
    });
  });
}

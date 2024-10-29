import 'package:example/circular_parameter_list.dart';
import 'package:example/circular_parameter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CircularParameterWidget displays title, label, and progress indicator correctly', (WidgetTester tester) async {
    // Arrange
    final parameterList = CircularParameterList<String>(label: 'Parameter 1', value: 'Value 1')
      .addParameter('Parameter 2', 'Value 2')
      .addParameter('Parameter 3', 'Value 3');

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CircularParameterWidget(
            title: 'Test Title',
            parameterList: parameterList,
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('Parameter 1'), findsOneWidget);
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

}

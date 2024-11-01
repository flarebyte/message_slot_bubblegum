import 'package:example/widget_data.dart';
import 'package:flutter/material.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';

import 'circular_parameter_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeData = WidgetThemeData().themeData;
  final _infoSlot = InfoSlot(tags: ['main']);
  final loopData = IterationData();

  void _incrementCounter() {
    setState(() {
      loopData.mainCircularIterator.next();
      _infoSlot.setValues(
          size: loopData.size.current().value,
          prominence: loopData.prominence.current().value,
          title: 'Some title',
          description: 'Some description');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BubblegumMessageSlot',
      theme: themeData.current().value,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('BubblegumMessageSlot'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  loopData.mainCircularIterator.reset();
                });
              },
              tooltip: 'Reset Content',
            ),
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () {
                themeData.next();
              },
              tooltip: 'Toggle Theme',
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularParameterWidget(
                  title: 'Theme', parameterList: themeData),
              CircularParameterWidget(
                  title: 'Size', parameterList: loopData.size),
              CircularParameterWidget(
                  title: 'Prominence', parameterList: loopData.prominence),
              CircularParameterWidget(
                  title: 'Messages', parameterList: loopData.slotMessages),
              Text(
                '${loopData.mainCircularIterator.currentIndex() + 1}/${loopData.mainCircularIterator.length()}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              BubblegumMessageSlot(
                  slot: _infoSlot,
                  messages: loopData.slotMessages.current().value),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}

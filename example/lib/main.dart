import 'package:example/widget_data.dart';
import 'package:flutter/material.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';

import 'circular_parameter_widget.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BubblegumMessageSlot Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo of BubblegumMessageSlot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: (){
              setState(() {
                loopData.mainCircularIterator.reset();
              });
            },
            tooltip: 'Reset Content',
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed:(){
              loopData.mainCircularIterator.reset();
            },
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularParameterWidget(title: 'Size', parameterList:  loopData.size),
            CircularParameterWidget(title: 'Prominence', parameterList:  loopData.prominence),
            CircularParameterWidget(title: 'Messages', parameterList:  loopData.slotMessages),
            Text(
              '${loopData.mainCircularIterator.currentIndex()+1}/${loopData.mainCircularIterator.length()}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            BubblegumMessageSlot(
                slot: _infoSlot, messages: loopData.slotMessages.current().value),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

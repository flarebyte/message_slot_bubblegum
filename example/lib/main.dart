import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'circular_parameter_list.dart';
import 'circular_parameter_widget.dart';

void main() {
  runApp(const MyApp());
}

class InfoSlot extends CopperframeSlotBase {
  InfoSlot({required super.tags});
}

class IterationData {
  late CircularParameterList slotMessages;
  late CircularParameterList prominence;
  late CircularParameterList size;
  late MultiCircularIterator mainCircularIterator;
  IterationData(){
    slotMessages = CircularParameterList<List<CopperframeMessage>>(
        label: 'single info',
        value: [MessageRepo.longInfo]).addParameter('error and info', [
      MessageRepo.error,
      MessageRepo.info
    ]).addParameter('error warning info', [
      MessageRepo.error,
      MessageRepo.warning,
      MessageRepo.info
    ]).addParameter('error and info', [
      MessageRepo.otherError,
      MessageRepo.error,
      MessageRepo.warning,
      MessageRepo.info
    ]).addParameter('6 messages', [
      MessageRepo.info,
      MessageRepo.warning,
      MessageRepo.info,
      MessageRepo.warning,
      MessageRepo.info,
      MessageRepo.warning,
    ]);
    prominence = CircularParameterList<String>(label: 'low', value: 'low')
        .addParameter('medium', 'medium')
        .addParameter('high', 'high');
    size = CircularParameterList<String>(label: 'small', value: 'small')
        .addParameter('medium', 'medium')
        .addParameter('large', 'large');
    mainCircularIterator = MultiCircularIterator([prominence, size, slotMessages]);

  }
}

class MessageRepo {
  static final info = CopperframeMessage(
      label: 'Some info',
      level: CopperframeMessageLevel.info,
      category: 'privacy');
  static final longInfo = CopperframeMessage(
      label:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus tincidunt massa sem, et pulvinar dolor sollicitudin vitae. Suspendisse porta nunc leo, eu sagittis tellus facilisis vitae. Integer placerat hendrerit ipsum, ac ornare justo blandit vel. Vivamus finibus tortor diam, in volutpat nibh semper vel. Proin mi ex, blandit rhoncus sodales',
      level: CopperframeMessageLevel.info,
      category: 'privacy');
  static final veryLongInfo = CopperframeMessage(
      label:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin non lorem sit amet tellus semper vestibulum. Cras sit amet purus aliquam lacus finibus fringilla. Donec nulla odio, gravida quis eros ac, consectetur feugiat est. Sed et mauris vel metus lacinia ullamcorper. Cras bibendum nisl semper sem vehicula dictum. Nam et felis risus. Suspendisse iaculis lacus nec finibus fermentum. Ut tempor faucibus augue at facilisis. Duis id facilisis augue. Etiam tellus purus, scelerisque vitae posuere ac, pretium ac nisl. Quisque a congue mi, in hendrerit ipsum. Duis sed fermentum metus. Phasellus tempor eu ligula ut laoreet. Fusce varius in massa sit.',
      level: CopperframeMessageLevel.info,
      category: 'privacy');
  static final warning = CopperframeMessage(
      label: 'Some warning',
      level: CopperframeMessageLevel.warning,
      category: 'validation');
  static final otherWarning = CopperframeMessage(
      label: 'Other warning',
      level: CopperframeMessageLevel.warning,
      category: 'validation');
  static final error = CopperframeMessage(
      label: 'Some error',
      level: CopperframeMessageLevel.error,
      category: 'server');
  static final otherError = CopperframeMessage(
      label: 'Other error', level: CopperframeMessageLevel.error, category: '');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

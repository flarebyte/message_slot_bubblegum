import 'package:flutter/material.dart';
import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:message_slot_bubblegum/message_slot_bubblegum.dart';
import 'package:slotboard_copperframe/slotboard_copperframe.dart';

import 'circular_parameter_list.dart';

void main() {
  runApp(const MyApp());
}

class InfoSlot extends CopperframeSlotBase {
  InfoSlot({required super.tags});
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final String _description = 'Start';
  final _infoSlot = InfoSlot(tags: ['main']);
  final slotMessages = CircularParameterList<List<CopperframeMessage>>(
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
  final prominence = CircularParameterList<String>(label: 'low', value: 'low')
      .addParameter('medium', 'medium')
      .addParameter('high', 'high');
  final size = CircularParameterList<String>(label: 'small', value: 'small')
      .addParameter('medium', 'medium')
      .addParameter('large', 'large');



  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;

      _infoSlot.setValues(
          size: size.current().value,
          prominence: prominence.current().value,
          title: 'Some title',
          description: 'Some description');
      prominence.next();
      if (prominence.currentIndex() == 0){
        size.next();
        if (size.currentIndex() == 0) {
          slotMessages.next();
        }
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _description,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            BubblegumMessageSlot(
                slot: _infoSlot, messages: slotMessages.current().value),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

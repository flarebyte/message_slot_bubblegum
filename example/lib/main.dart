import 'package:example/widget_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  final localeData = WidgetLocaleData().localeData;
  final _infoSlot = InfoSlot(tags: ['main']);
  final loopData = IterationData();
  var clickCounter = 0;

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
      showSemanticsDebugger: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      locale: localeData.current().value,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('BubblegumMessageSlot',
              style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              icon: const Icon(Icons.flag, color: Colors.black),
              onPressed: () {
                setState(() {
                  localeData.next();
                });
              },
              tooltip: 'Toggle Locale',
            ),
            IconButton(
              icon: const Icon(Icons.brightness_6, color: Colors.black),
              onPressed: () {
                setState(() {
                  themeData.next();
                });
              },
              tooltip: 'Toggle Theme',
            ),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: () {
                setState(() {
                  loopData.mainCircularIterator.reset();
                });
              },
              tooltip: 'Reset Content',
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularParameterWidget(title: 'Theme', parameterList: themeData),
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
                messages: loopData.slotMessages.current().value,
                options: BubblegumMessageSlotOptsBuilder()
                    .setIconCollection(IconRepo.iconCollection)
                    .setGroupMessagesByLevel(true)
                    .setOnTapHint('Fix the content')
                    .setOnMessageTap((message) => setState(() {
                          clickCounter++;
                        }))
                    .build(),
              ),
              Text(
                'Clicks $clickCounter',
                style: Theme.of(context).textTheme.bodySmall,
              ),
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

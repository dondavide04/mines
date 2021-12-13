import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mines',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Text('demo'),
    );
  }
}

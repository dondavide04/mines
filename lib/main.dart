import 'package:flutter/material.dart';
import 'package:mines/routes.dart';
import 'package:mines/routes/home/home.dart';
import 'package:mines/routes/stats/stats.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mines',
      initialRoute: '/',
      routes: {
        Routes.home: (_) => const Home(),
        Routes.stats: (_) => const Stats(),
      },
    );
  }
}

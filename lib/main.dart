import 'package:flutter/material.dart';
import 'package:mines/routes/game/game.dart';
import 'package:mines/routes/home.dart';

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
        '/': (_) => const Home(),
        '/game': (_) => const Game(),
      },
    );
  }
}

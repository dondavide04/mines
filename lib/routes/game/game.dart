import 'package:flutter/material.dart';
import 'package:mines/routes/game/box.dart';

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        widthFactor: double.infinity,
        heightFactor: double.infinity,
        child: SafeArea(
          minimum: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Box(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

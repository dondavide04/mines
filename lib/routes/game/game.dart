import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        widthFactor: double.infinity,
        heightFactor: double.infinity,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('back'),
        ),
      ),
    );
  }
}

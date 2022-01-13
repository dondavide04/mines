import 'package:flutter/material.dart';
import 'package:mines/routes.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        widthFactor: double.infinity,
        heightFactor: double.infinity,
        child: ElevatedButton(
          child: const Text('Start'),
          onPressed: () => Navigator.pushNamed(context, Routes.game),
        ),
      ),
    );
  }
}

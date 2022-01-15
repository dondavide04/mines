import 'package:flutter/material.dart';
import 'package:mines/routes.dart';
import 'package:mines/routes/home/widgets/settingsDialog.dart';

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
          onPressed: () => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const SettingsDialog())
              .then((value) => print(value)),
        ),
      ),
    );
  }
}

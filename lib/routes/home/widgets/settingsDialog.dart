import 'package:flutter/material.dart';

class Settings {
  final int size;
  final int mines;

  Settings(this.size, this.mines);
  Settings.easy()
      : size = 8,
        mines = 6;
  Settings.medium()
      : size = 8,
        mines = 13;
  Settings.hard()
      : size = 8,
        mines = 20;
}

enum Difficulties { easy, medium, hard }

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  int size = 8;
  int mines = 13;

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: const Text('Choose settings'),
          content: Column(
            children: [
              Text('Size = $size'),
              Slider(
                value: size.toDouble(),
                onChanged: (size) => setState(() {
                  this.size = size.toInt();
                }),
                min: 5,
                max: 15,
                divisions: 10,
              )
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, '');
                },
                child: const Text('Confirm'))
          ]);
}

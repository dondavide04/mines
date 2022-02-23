import 'package:flutter/material.dart';

class Settings {
  final int size;
  final int mines;

  Settings(this.size, this.mines);
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
  int get maxMines => (size * size * 30 / 100).round();
  int get minMines => (size * size * 10 / 100).round();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Choose settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Size = $size'),
            Slider(
              value: size.toDouble(),
              onChanged: (size) => setState(() {
                this.size = size.toInt();
                if (mines > maxMines) {
                  (mines = maxMines);
                }
                if (mines < minMines) {
                  (mines = minMines);
                }
              }),
              min: 5,
              max: 15,
            ),
            Text('Mines = $mines'),
            Slider(
              value: mines.toDouble(),
              onChanged: (mines) => setState(() {
                this.mines = mines.toInt();
              }),
              min: minMines.toDouble(),
              max: maxMines.toDouble(),
            )
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, Settings(size, mines));
                },
                child: const Text('Confirm')),
          )
        ]);
  }
}

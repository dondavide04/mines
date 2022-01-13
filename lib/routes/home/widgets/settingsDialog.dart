import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) => Wrap(
      direction: Axis.vertical, children: const [Text('select difficulty')]);
}

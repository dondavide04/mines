import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  const Box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('content'),
      padding: const EdgeInsets.all(8),
    );
  }
}

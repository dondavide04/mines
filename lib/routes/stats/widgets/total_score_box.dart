import 'package:flutter/material.dart';

enum Type { won, lost }

class TotalScoreBox extends StatelessWidget {
  final int total;
  final String title;
  final Type type;

  const TotalScoreBox(
      {Key? key, required this.total, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      Text(total.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: type == Type.lost
                  ? Theme.of(context).errorColor
                  : Theme.of(context).primaryColor))
    ]);
  }
}

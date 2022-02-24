import 'package:flutter/material.dart';

class TotalScoreBox extends StatelessWidget {
  final int total;
  final String title;
  const TotalScoreBox({Key? key, required this.total, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(title), Text(total.toString())]);
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mines/database/match.dart';

class MatchItem extends StatelessWidget {
  final Match match;

  const MatchItem({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(DateFormat('MMM, d - kk:mm:ss').format(match.startedAt)),
      Text(match.win ? 'won' : 'lost'),
      Text(match.endedAt != null
          ? DateFormat('MMM, d - kk:mm:ss').format(match.endedAt!)
          : '')
    ]);
  }
}

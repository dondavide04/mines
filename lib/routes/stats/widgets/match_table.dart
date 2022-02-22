import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mines/database/match.dart';

class MatchTable extends StatelessWidget {
  final List<Match> data;
  const MatchTable({Key? key, required this.data}) : super(key: key);

  String _formatTime(Duration d) =>
      '${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Outcome')),
          DataColumn(label: Text('Time')),
          DataColumn(label: Text('Mines %'))
        ],
        rows: data
            .where((m) => m.endedAt != null)
            .map((m) => DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text(DateFormat('MMM, d').format(m.startedAt)),
                    ),
                    DataCell(
                      Text(m.win ? 'Won' : 'Lost'),
                    ),
                    DataCell(
                      Text(_formatTime(m.endedAt!.difference(m.startedAt))),
                    ),
                    DataCell(
                      Text('${(m.mines * 100 / m.cells).round().toString()} %'),
                    ),
                  ],
                ))
            .toList());
  }
}

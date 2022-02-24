import 'package:flutter/material.dart';
import 'package:mines/database/matches_database.dart';
import 'package:mines/database/match.dart';
import 'package:mines/routes/stats/widgets/match_table.dart';
import 'package:mines/routes/stats/widgets/total_score_box.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Statistics')),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Center(
            heightFactor: 1,
            child: FutureBuilder<List<Match>>(
              future: MatchesDatabase.instance.readAll(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TotalScoreBox(
                                title: 'Total won',
                                total: snapshot.data!.fold(
                                    0,
                                    (previousValue, element) => element.win
                                        ? previousValue + 1
                                        : previousValue)),
                            TotalScoreBox(
                                title: 'Total lost',
                                total: snapshot.data!.fold(
                                    0,
                                    (previousValue, element) =>
                                        !element.win && element.endedAt != null
                                            ? previousValue + 1
                                            : previousValue))
                          ],
                        ),
                        const SizedBox(height: 56),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: MatchTable(data: snapshot.data!))
                      ])
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            )),
      ),
    );
  }
}

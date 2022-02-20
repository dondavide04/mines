import 'package:flutter/material.dart';
import 'package:mines/database/matches_database.dart';
import 'package:mines/database/match.dart';
import 'package:mines/routes/stats/widgets/match_item.dart';

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
        child: FutureBuilder<List<Match>>(
          future: MatchesDatabase.instance.readAll(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, position) =>
                        MatchItem(match: snapshot.data![position]))
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

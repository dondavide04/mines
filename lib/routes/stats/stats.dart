import 'package:flutter/material.dart';
import 'package:mines/database/matches_database.dart';
import 'package:mines/database/match.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Statistics')),
      body: FutureBuilder<List<Match>>(
        future: MatchesDatabase.instance.readAll(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, position) {
                    final item = snapshot.data![position];
                    return Text(item.startedAt.toString());
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

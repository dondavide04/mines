import 'package:flutter/material.dart';
import 'package:mines/routes/game/box.dart';

const gameSize = 9;
const totalMines = 27;

List<List<int>> _mkGameBoard() {
  final flatBoard = List.filled(totalMines, 1, growable: true);
  flatBoard.addAll(List.filled((gameSize * gameSize) - totalMines, 0));
  flatBoard.shuffle();
  return List.generate(gameSize, (index) {
    final start = index * gameSize;
    final end = start + gameSize;
    return flatBoard.sublist(start, end);
  }, growable: false);
}

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<Game> {
  final List<List<int>> board;

  _GameState() : board = _mkGameBoard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Wrap(
          direction: Axis.vertical,
          spacing: 8,
          children: board
              .map(
                (row) => Wrap(
                  spacing: 8,
                  children: row.map((e) => Box(content: e)).toList(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

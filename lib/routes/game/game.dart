import 'package:flutter/material.dart';
import 'package:mines/routes/game/box.dart';
import 'package:collection/collection.dart';

const gameSize = 9;
const totalMines = 15;

class Cell {
  final bool isMine;
  final int aroundMines;

  Cell.mine()
      : isMine = true,
        aroundMines = 0;
  Cell.number(this.aroundMines) : isMine = false;
}

List<List<Cell>> _mkGameBoard() {
  final flatMines = List.filled(totalMines, 1, growable: true);
  flatMines.addAll(List.filled((gameSize * gameSize) - totalMines, 0));
  flatMines.shuffle();
  final flatBoard = flatMines
      .mapIndexed((i, e) => e == 1
          ? Cell.mine()
          : Cell.number([
              i % gameSize == 0
                  ? [
                      i - gameSize,
                      i - gameSize + 1,
                      i + 1,
                      i + gameSize,
                      i + gameSize + 1
                    ]
                  : i % gameSize == (gameSize - 1)
                      ? [
                          i - gameSize,
                          i - gameSize - 1,
                          i - 1,
                          i + gameSize,
                          i + gameSize - 1
                        ]
                      : [
                          i - gameSize - 1,
                          i - gameSize,
                          i - gameSize + 1,
                          i - 1,
                          i + 1,
                          i + gameSize - 1,
                          i + gameSize,
                          i + gameSize + 1
                        ],
            ].expand((e) => e).fold(
              0,
              (acc, value) => value < flatMines.length && value > 0
                  ? acc + flatMines[value]
                  : acc)))
      .toList();

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
  final List<List<Cell>> board;

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
                  children: row.map((e) => Box(cell: e)).toList(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

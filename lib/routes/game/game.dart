import 'package:flutter/material.dart';
import 'package:mines/routes/game/utils/mkGameBoard.dart';
import 'package:mines/routes/game/widgets/box.dart';
import 'package:collection/collection.dart';
import 'package:mines/routes/game/widgets/cell.dart';

const gameSize = 9;
const totalMines = 15;

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<List<Cell>>? board;
  bool isStarted = false;

  _onTapCell(int xCoord, int yCoord) {
    if (!isStarted) {
      setState(() {
        isStarted = true;
        board = mkGameBoard(
            gameSize: gameSize,
            totalMines: totalMines,
            xFirst: xCoord,
            yFirst: yCoord);
      });
    }
  }

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
          children: (board ??
                  List.filled(gameSize, List.filled(gameSize, Cell.number(0))))
              .mapIndexed(
                (rowIndex, row) => Wrap(
                  spacing: 8,
                  children: row
                      .mapIndexed((colIndex, cell) => Box(
                            content: CellWidget(cell: cell),
                            xCoord: rowIndex,
                            yCoord: colIndex,
                            onTap: _onTapCell,
                          ))
                      .toList(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

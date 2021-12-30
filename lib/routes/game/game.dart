import 'package:flutter/material.dart';
import 'package:mines/routes/game/utils/mkGameBoard.dart';
import 'package:mines/routes/game/widgets/box.dart';
import 'package:collection/collection.dart';
import 'package:mines/routes/game/widgets/cell.dart';

const gameSize = 9;
const totalMines = 15;

class CellWithVisibility {
  final Cell cell;
  bool isVisible = false;

  bool isNotVisible() => !isVisible;

  CellWithVisibility(this.cell);
}

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<List<CellWithVisibility>>? board;
  bool isStarted = false;

  void _restart() {
    setState(() {
      isStarted = false;
      board = null;
    });
  }

  void _win() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => _endDialog('You won'));

  void _loose() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => _endDialog('You lost'));

  AlertDialog _endDialog(String title) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
              child: const Text('back'),
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst)),
          TextButton(
            child: const Text('restart'),
            onPressed: () {
              _restart();
              Navigator.pop(context);
            },
          )
        ],
      );

  void _checkCell(int xCoord, int yCoord) {
    // check loosing condition
    if (board![xCoord][yCoord].cell.isMine) {
      _loose();
    }

    // make visible
    board![xCoord][yCoord].isVisible = true;
    // check around cells
    if (board![xCoord][yCoord].cell.aroundMines == 0) {
      board!.aroundIndexes(x: xCoord, y: yCoord).forEach((coord) {
        if (!board![coord.x][coord.y].isVisible) {
          _checkCell(coord.x, coord.y);
        }
      });
    }

    // check winning condition
    if (board!.flatten().where((cell) => cell.isNotVisible()).length ==
        totalMines) {
      _win();
    }
  }

  void _onTapCell(int xCoord, int yCoord) {
    setState(() {
      if (!isStarted) {
        board = mkGameBoard(
                gameSize: gameSize,
                totalMines: totalMines,
                xFirst: xCoord,
                yFirst: yCoord)
            .map((row) => row.map((cell) => CellWithVisibility(cell)).toList())
            .toList();
        isStarted = true;
      }
      _checkCell(xCoord, yCoord);
    });
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
                  List.filled(
                      gameSize,
                      List.filled(
                          gameSize, CellWithVisibility(Cell.number(0)))))
              .mapIndexed(
                (rowIndex, row) => Wrap(
                  spacing: 8,
                  children: row
                      .mapIndexed((colIndex, visibleCell) => Box(
                            content: CellWidget(cell: visibleCell.cell),
                            xCoord: rowIndex,
                            yCoord: colIndex,
                            onTap: _onTapCell,
                            isVisible: visibleCell.isVisible,
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

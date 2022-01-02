import 'package:flutter/material.dart';
import 'package:mines/routes/game/utils/mkGameBoard.dart';
import 'package:mines/routes/game/widgets/box.dart';
import 'package:collection/collection.dart';
import 'package:mines/routes/game/widgets/cell.dart';

const gameSize = 9;
const totalMines = 15;

class StatefulCell {
  final Cell cell;
  BoxStatus status = BoxStatus.notVisible;

  bool isNotVisible() => status != BoxStatus.visible;
  bool isFlagged() => status == BoxStatus.flagged;
  void setVisible() => status = BoxStatus.visible;
  void setNotVisible() => status = BoxStatus.notVisible;
  void setFlagged() => status = BoxStatus.flagged;

  StatefulCell(this.cell);
}

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<List<StatefulCell>>? board;

  void _restart() {
    setState(() {
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
    // make visible
    board![xCoord][yCoord].setVisible();

    if (board![xCoord][yCoord].cell.isMine) {
      // check loosing condition
      _loose();
    } else if (board!.flatten().where((cell) => cell.isNotVisible()).length ==
        totalMines) {
      // check winning condition
      _win();
    } else if (board![xCoord][yCoord].cell.aroundMines == 0) {
      // check around cells
      board!.aroundIndexes(x: xCoord, y: yCoord).forEach((coord) {
        if (board![coord.x][coord.y].isNotVisible()) {
          _checkCell(coord.x, coord.y);
        }
      });
    }
  }

  void _onTapCell(int xCoord, int yCoord, BoxStatus status) => setState(() {
        board ??= mkGameBoard(
                gameSize: gameSize,
                totalMines: totalMines,
                xFirst: xCoord,
                yFirst: yCoord)
            .map((row) => row.map((cell) => StatefulCell(cell)).toList())
            .toList();
        if (status == BoxStatus.flagged) {
          board![xCoord][yCoord].setNotVisible();
        } else {
          _checkCell(xCoord, yCoord);
        }
      });

  void _onLongPressCell(int xCoord, int yCoord, BoxStatus status) =>
      setState(() {
        if (board == null) {
          _onTapCell(xCoord, yCoord, status);
        } else if (status == BoxStatus.notVisible) {
          board![xCoord][yCoord].setFlagged();
        } else if (status == BoxStatus.flagged) {
          board![xCoord][yCoord].setNotVisible();
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                    child: Image.asset('assets/images/bomb.png'),
                    height: 32,
                    padding: const EdgeInsets.all(8)),
                Text(totalMines.toString())
              ],
            ),
            const SizedBox(width: 32),
            Row(
              children: [
                Container(
                    child: Image.asset('assets/images/flag.png'),
                    height: 32,
                    padding: const EdgeInsets.all(4)),
                Text(board
                        ?.flatten()
                        .where((cell) => cell.isFlagged())
                        .length
                        .toString() ??
                    '0')
              ],
            ),
          ],
        ),
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
                      gameSize,
                      StatefulCell(Cell.number(0)),
                    ),
                  ))
              .mapIndexed(
                (rowIndex, row) => Wrap(
                  spacing: 8,
                  children: row
                      .mapIndexed((colIndex, statefulCell) => Box(
                            content: CellWidget(cell: statefulCell.cell),
                            xCoord: rowIndex,
                            yCoord: colIndex,
                            onTap: _onTapCell,
                            onLongPress: _onLongPressCell,
                            status: statefulCell.status,
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

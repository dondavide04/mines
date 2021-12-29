import 'package:flutter/material.dart';

class Cell {
  final bool isMine;
  final int aroundMines;

  Cell.mine()
      : isMine = true,
        aroundMines = 0;
  Cell.number(this.aroundMines) : isMine = false;
}

class CellWidget extends StatelessWidget {
  final Cell cell;

  const CellWidget({Key? key, required this.cell}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(cell.isMine
      ? 'mine'
      : cell.aroundMines == 0
          ? ''
          : cell.aroundMines.toString());
}

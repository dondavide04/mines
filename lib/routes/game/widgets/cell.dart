import 'package:flutter/material.dart';

class Cell {
  final bool isMine;
  final int aroundMines;

  Cell(this.aroundMines, this.isMine);
}

class CellWidget extends StatelessWidget {
  final Cell cell;

  const CellWidget({Key? key, required this.cell}) : super(key: key);

  @override
  Widget build(BuildContext context) => cell.isMine
      ? Image.asset('assets/images/bomb.png')
      : Center(
          child: Text(cell.aroundMines == 0 ? '' : cell.aroundMines.toString()),
        );
}

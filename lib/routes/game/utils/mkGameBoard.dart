import 'package:collection/collection.dart';
import 'package:mines/routes/game/widgets/cell.dart';

class MatrixIndexes {
  final int x;
  final int y;

  const MatrixIndexes(this.x, this.y);
}

extension Matrix<T> on List<List<T>> {
  List<List<T>> around({required int x, required int y}) =>
      whereIndexed((rowIndex, _) => rowIndex <= (x + 1) && rowIndex >= (x - 1))
          .map((col) => col
              .whereIndexed(
                  (colIndex, _) => colIndex <= (y + 1) && colIndex >= (y - 1))
              .toList())
          .toList();

  List<MatrixIndexes> aroundIndexes({required int x, required int y}) =>
      mapIndexed((rowIndex, col) => col
          .mapIndexed((colIndex, _) => MatrixIndexes(rowIndex, colIndex))
          .toList()).toList().around(x: x, y: y).flatten().toList();

  Iterable<T> flatten() => expand((element) => element);
}

List<List<Cell>> mkGameBoard(
    {required int gameSize,
    required int totalMines,
    required int xFirst,
    required int yFirst}) {
  final tempBoard = List.generate(
    gameSize,
    (x) => List.generate(
        gameSize,
        (y) => x <= (xFirst + 1) &&
                x >= (xFirst - 1) &&
                y <= (yFirst + 1) &&
                y >= (yFirst - 1)
            ? false
            : null),
  );
  final flatMines = List.filled(totalMines, true, growable: true);
  flatMines.addAll(List.filled(
      tempBoard.flatten().where((el) => el == null).length - totalMines,
      false));
  flatMines.shuffle();
  final numBoard = tempBoard
      .map(
          (column) => column.map((el) => el ?? flatMines.removeLast()).toList())
      .toList();
  return numBoard
      .mapIndexed((rowIndex, row) => row
          .mapIndexed((colIndex, isMine) => isMine
              ? Cell.mine()
              : Cell.number(numBoard
                  .around(x: rowIndex, y: colIndex)
                  .flatten()
                  .where((isMine) => isMine)
                  .length))
          .toList())
      .toList();
}

import 'package:mines/routes/game/utils/gameBoard.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

void main() {
  test('around method on an empty Matrix should return an empty Matrix', () {
    const List<List<dynamic>> matrix = [];

    expect(matrix.around(x: 0, y: 0), []);
    expect(matrix.around(x: 1, y: 0), []);
    expect(matrix.around(x: 0, y: 1), []);
    expect(matrix.around(x: 1, y: 1), []);
    expect(matrix.around(x: -1, y: 0), []);
    expect(matrix.around(x: 0, y: -1), []);
    expect(matrix.around(x: -1, y: -1), []);
    expect(matrix.around(x: -1, y: 1), []);
    expect(matrix.around(x: 1, y: -1), []);
    expect(matrix.around(x: -2, y: -2), []);
    expect(matrix.around(x: 2, y: 2), []);
  });

  test('aroundIndexes method on an empty Matrix should return an empty list',
      () {
    const List<List<dynamic>> matrix = [];

    expect(matrix.aroundIndexes(x: 0, y: 0), []);
    expect(matrix.aroundIndexes(x: 1, y: 0), []);
    expect(matrix.aroundIndexes(x: 0, y: 1), []);
    expect(matrix.aroundIndexes(x: 1, y: 1), []);
    expect(matrix.aroundIndexes(x: -1, y: 0), []);
    expect(matrix.aroundIndexes(x: 0, y: -1), []);
    expect(matrix.aroundIndexes(x: -1, y: -1), []);
    expect(matrix.aroundIndexes(x: -1, y: 1), []);
    expect(matrix.aroundIndexes(x: 1, y: -1), []);
    expect(matrix.aroundIndexes(x: -2, y: -2), []);
    expect(matrix.aroundIndexes(x: 2, y: 2), []);
  });

  test(
      'around method on a filled Matrix should return the surrounding submatrix starting from the chosen indexes',
      () {
    const matrix = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ];

    expect(matrix.around(x: 0, y: 0), [
      [1, 2],
      [4, 5]
    ]);
    expect(matrix.around(x: 0, y: 1), [
      [1, 2, 3],
      [4, 5, 6]
    ]);
    expect(matrix.around(x: 0, y: 2), [
      [2, 3],
      [5, 6]
    ]);
    expect(matrix.around(x: 1, y: 0), [
      [1, 2],
      [4, 5],
      [7, 8]
    ]);
    expect(matrix.around(x: 2, y: 0), [
      [4, 5],
      [7, 8]
    ]);
    expect(matrix.around(x: 1, y: 1), [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]);
    expect(matrix.around(x: -1, y: -1), [
      [1],
    ]);
    expect(matrix.around(x: 3, y: 3), [
      [9],
    ]);
    expect(matrix.around(x: -2, y: -2), []);
    expect(matrix.around(x: 4, y: 4), []);
  });

  test(
      'aroundIndexes method on a filled Matrix should return the list of Indexes of the surrounding submatrix starting from the chosen indexes',
      () {
    const matrix = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ];

    expect(matrix.aroundIndexes(x: 0, y: 0), const [
      MatrixIndexes(0, 0),
      MatrixIndexes(0, 1),
      MatrixIndexes(1, 0),
      MatrixIndexes(1, 1),
    ]);
    expect(matrix.aroundIndexes(x: 0, y: 1), const [
      MatrixIndexes(0, 0),
      MatrixIndexes(0, 1),
      MatrixIndexes(0, 2),
      MatrixIndexes(1, 0),
      MatrixIndexes(1, 1),
      MatrixIndexes(1, 2),
    ]);
    expect(matrix.aroundIndexes(x: 0, y: 2), const [
      MatrixIndexes(0, 1),
      MatrixIndexes(0, 2),
      MatrixIndexes(1, 1),
      MatrixIndexes(1, 2),
    ]);
    expect(matrix.aroundIndexes(x: 1, y: 0), const [
      MatrixIndexes(0, 0),
      MatrixIndexes(0, 1),
      MatrixIndexes(1, 0),
      MatrixIndexes(1, 1),
      MatrixIndexes(2, 0),
      MatrixIndexes(2, 1),
    ]);
    expect(matrix.aroundIndexes(x: 2, y: 0), const [
      MatrixIndexes(1, 0),
      MatrixIndexes(1, 1),
      MatrixIndexes(2, 0),
      MatrixIndexes(2, 1),
    ]);
    expect(matrix.aroundIndexes(x: 1, y: 1), const [
      MatrixIndexes(0, 0),
      MatrixIndexes(0, 1),
      MatrixIndexes(0, 2),
      MatrixIndexes(1, 0),
      MatrixIndexes(1, 1),
      MatrixIndexes(1, 2),
      MatrixIndexes(2, 0),
      MatrixIndexes(2, 1),
      MatrixIndexes(2, 2),
    ]);
    expect(matrix.aroundIndexes(x: -1, y: -1), const [
      MatrixIndexes(0, 0),
    ]);
    expect(matrix.aroundIndexes(x: 3, y: 3), const [
      MatrixIndexes(2, 2),
    ]);
    expect(matrix.aroundIndexes(x: -2, y: -2), []);
    expect(matrix.aroundIndexes(x: 4, y: 4), []);
  });

  test('mkGameBoard should create a square game board', () {
    const size = 8;
    const totalMines = 8;
    const xFirst = 0;
    const yFirst = 0;

    final board = mkGameBoard(
        gameSize: size, totalMines: totalMines, xFirst: xFirst, yFirst: yFirst);

    expect(board.length, size);
    for (final row in board) {
      expect(row.length, size);
    }
    expect(board[xFirst][yFirst].aroundMines, 0);
    expect(board[xFirst][yFirst].isMine, false);
    expect(
        board.around(x: xFirst, y: yFirst).flattened.any((cell) => cell.isMine),
        false);
    expect(board.flattened.where((cell) => cell.isMine).length, totalMines);
    board.forEachIndexed((rowIndex, row) {
      row.forEachIndexed((colIndex, cell) {
        expect(
            cell.aroundMines,
            board
                .around(x: rowIndex, y: colIndex)
                .flattened
                .where((cell) => cell.isMine)
                .length);
      });
    });
  });
}

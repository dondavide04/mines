import 'package:mines/routes/game/utils/gameBoard.dart';
import 'package:test/test.dart';

void main() {
  test('mkGameBoard should create a square game board', () {
    const size = 8;
    final board =
        mkGameBoard(gameSize: size, totalMines: 8, xFirst: 0, yFirst: 0);

    expect(board.length, size);
    for (final row in board) {
      expect(row.length, size);
    }
    expect(board[0][0].aroundMines, 0);
    expect(board[0][0].isMine, false);
  });
}

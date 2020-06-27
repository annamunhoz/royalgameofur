import 'ur_board.dart';

class UrGame {
  UrGame() {
    urBoard = UrBoard();
    _movePiece = {1: urBoard.movePlayerOnePiece, 2: urBoard.movePlayerTwoPiece};
    hasPiece = {1: urBoard.hasPlayerOnePiece, 2: urBoard.hasPlayerTwoPiece};
    track = {
      1: urBoard.playerOneTrack,
      2: urBoard.playerTwoTrack,
    };
  }

  bool playerTwoHuman;
  UrBoard urBoard;
  Map<int, Function> _movePiece;
  Map<int, Function> hasPiece;
  Map<int, List<String>> track;

  List<List<String>> getAvailableMoves(int player, int diceRoll) {
    if (diceRoll == 0) {
      return [];
    }

    final possibleMoves = <List<String>>[];

    for (var i = 0; i < track.length; i++) {
      if (hasPiece[player](track[player][i]) &&
          canMovePiece(player, i, i + diceRoll)) {
        possibleMoves.add([track[player][i], track[player][i + diceRoll]]);
      }
    }

    return possibleMoves;
  }

  bool canMovePiece(int player, int indexFrom, int indexDestiny) {
    if (indexDestiny > track.length) {
      return false;
    }

    if (hasPiece[player](track[indexDestiny])) {
      return false;
    }

    if (urBoard.boardMap[track[indexDestiny]].isSpecial &&
        hasPiece[getOpponent(player)](track[indexDestiny])) {
      return false;
    }

    return true;
  }

  int getOpponent(int player) => player == 1 ? 2 : 1;

  void movePiece(int player, String tileFrom, String tileDestiny) {
    _movePiece[player](tileFrom, tileDestiny);
  }
}

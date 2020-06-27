import 'ur_board.dart';

class UrGame {
  UrGame() {
    urBoard = UrBoard();
    movePiece = {1: urBoard.movePlayerOnePiece, 2: urBoard.movePlayerTwoPiece};
    hasPiece = {1: urBoard.hasPlayerOnePiece, 2: urBoard.hasPlayerTwoPiece};
    track = {
      1: urBoard.playerOneTrack,
      2: urBoard.playerTwoTrack,
    };
  }

  bool playerTwoHuman;
  UrBoard urBoard;
  Map<int, Function> movePiece;
  Map<int, Function> hasPiece;
  Map<int, List<String>> track;

  List<String> getAvailableMoves(int player, int diceRoll) {
    if (diceRoll == 0) {
      return [];
    }

    final possibleMoves = <String>[];

    for (var i = 0; i < track.length; i++) {
      if (hasPiece[player](track[player][i]) &&
          canMovePiece(player, i, i + diceRoll)) {
        possibleMoves.add(track[player][i]);
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
}

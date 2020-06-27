import 'package:domain/models/tile.dart';

import 'ur_board.dart';

class UrGame {
  UrGame(this.urBoard) {
    _movePiece = {1: urBoard.movePlayerOnePiece, 2: urBoard.movePlayerTwoPiece};
    hasPiece = {1: urBoard.hasPlayerOnePiece, 2: urBoard.hasPlayerTwoPiece};
    track = {1: urBoard.playerOneTrack, 2: urBoard.playerTwoTrack};
  }

  final UrBoard urBoard;
  bool playerTwoHuman;
  Map<int, Function> _movePiece;
  Map<int, Function> hasPiece;
  Map<int, List<String>> track;
  bool finished = false;

  List<List<String>> getAvailableMoves(int player, int diceRoll) {
    if (diceRoll == 0) {
      return [];
    }

    final possibleMoves = <List<String>>[];

    for (var i = 0; i < track.length; i++) {
      if (hasPiece[player](track[player][i]) &&
          canMovePiece(player, i, i + diceRoll)) {
        possibleMoves.add([track[player][i], track[player][i + diceRoll]]);
        urBoard.boardMap[track[player][i]].canMove = true;
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

  // TODO: update method
  void movePiece(int trackIndex) {
//    _movePiece[player](tileFrom, tileDestiny);
  }

  Map<String, Tile> getBoardMap() => urBoard.boardMap;

  // TODO: create method
  int rollDice() => 4;

  // TODO: update method
  bool hasRolledDice() => true;

  // TODO: get current player
  int getCurrentPlayer() => 1;

  // TODO: create method
  int getWinnerPlayer() => 1;
}

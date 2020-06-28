import 'dart:math';

import 'package:domain/models/tile.dart';

import 'ur_board.dart';

class UrGame {
  UrGame(this.urBoard) {
    _movePiece = {1: urBoard.movePlayerOnePiece, 2: urBoard.movePlayerTwoPiece};
    hasPiece = {1: urBoard.hasPlayerOnePiece, 2: urBoard.hasPlayerTwoPiece};
    track = {1: urBoard.playerOneTrack, 2: urBoard.playerTwoTrack};
    currentPlayer = 1;
    finished = false;
    hasRolledDice = false;
    playerTwoHuman = true;
    canPlayerMove = true;
  }

  final UrBoard urBoard;
  bool playerTwoHuman;
  Map<int, Function> _movePiece;
  Map<int, Function> hasPiece;
  Map<int, List<String>> track;
  int currentPlayer;
  int rolledNumber;
  bool finished;
  bool hasRolledDice;
  bool canPlayerMove;

  List<List<String>> getAvailableMoves() {
    if (rolledNumber == 0) {
      canPlayerMove = false;
      return [];
    }

    final possibleMoves = <List<String>>[];

    for (var i = 0; i < track[currentPlayer].length; i++) {
      if (hasPiece[currentPlayer](track[currentPlayer][i]) &&
          canMovePiece(currentPlayer, i, i + rolledNumber)) {
        possibleMoves.add(
            [track[currentPlayer][i], track[currentPlayer][i + rolledNumber]]);
        urBoard.boardMap[track[currentPlayer][i]].canMove = true;
      }
    }

    if (possibleMoves.length > 0) {
      canPlayerMove = true;
    } else {
      canPlayerMove = false;
    }

    return possibleMoves;
  }

  void disableAllPossibleMoves() {
    urBoard.boardMap.forEach((k, v) => disableTileMove(k));
  }

  void disableTileMove(String tile) {
    urBoard.boardMap[tile].canMove = false;
  }

  bool canMovePiece(int player, int indexFrom, int indexDestiny) {
    if (indexDestiny > track[player].length - 1) {
      return false;
    }

    if (hasPiece[player](track[player][indexDestiny]) && indexDestiny != 15) {
      return false;
    }

    if (urBoard.boardMap[track[player][indexDestiny]].isSpecial &&
        hasPiece[getOpponent()](track[player][indexDestiny])) {
      return false;
    }

    return true;
  }

  int getOpponent() => currentPlayer == 1 ? 2 : 1;

  void movePiece(int trackIndex) {
    var fromTileName = track[currentPlayer][trackIndex];
    var destinyTileName = track[currentPlayer][trackIndex + rolledNumber];
    _movePiece[currentPlayer](fromTileName, destinyTileName);

    if (urBoard.boardMap[destinyTileName].isSpecial) {
      playAgain();
    } else {
      nextTurn();
    }
  }

  void playAgain() {
    hasRolledDice = false;
    disableAllPossibleMoves();
  }

  void nextTurn() {
    currentPlayer = getOpponent();
    hasRolledDice = false;
    disableAllPossibleMoves();

    endGameIfPossible();

    if (currentPlayer == 2 && !playerTwoHuman && !finished) {
      playAITurn();
    }
  }

  void playAITurn() {
    disableAllPossibleMoves();
    rollDice();
    final moves = getAvailableMoves();

    if (moves.length > 0) {
      final tile = urBoard.boardMap[moves[Random().nextInt(moves.length)][0]];
      movePiece(tile.trackIndex);
      if (hasRolledDice == false) {
        playAITurn();
      }
    } else {
      nextTurn();
    }
  }

  Map<String, Tile> getBoardMap() => urBoard.boardMap;

  int rollDice() {
    final r = Random();
    rolledNumber = r.nextInt(2) + r.nextInt(2) + r.nextInt(2) + r.nextInt(2);
    hasRolledDice = true;
    getAvailableMoves();
    return rolledNumber;
  }

  int getWinnerPlayer() {
    if (urBoard.boardMap['20'].playerOnePieces == 5) {
      return 1;
    } else {
      return 2;
    }
  }

  void endGameIfPossible() {
    if (urBoard.boardMap['20'].playerOnePieces == 5) {
      finished = true;
    }
    if (urBoard.boardMap['22'].playerTwoPieces == 5) {
      finished = true;
    }
  }
}

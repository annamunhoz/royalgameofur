import 'package:domain/models/tile.dart';
import 'dart:math';
import 'ur_board.dart';

class UrGame {
  UrGame(this.urBoard) {
    _movePiece = {1: urBoard.movePlayerOnePiece, 2: urBoard.movePlayerTwoPiece};
    hasPiece = {1: urBoard.hasPlayerOnePiece, 2: urBoard.hasPlayerTwoPiece};
    track = {1: urBoard.playerOneTrack, 2: urBoard.playerTwoTrack};
    currentPlayer = 1;
    finished = false;
    hasRolledDice = false;
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

  List<List<String>> getAvailableMoves() {
    if (rolledNumber == 0) {
      return [];
    }

    final possibleMoves = <List<String>>[];

    for (var i = 0; i < track.length; i++) {
      if (hasPiece[currentPlayer](track[currentPlayer][i]) &&
          canMovePiece(currentPlayer, i, i + rolledNumber)) {
        possibleMoves.add([track[currentPlayer][i], track[currentPlayer][i + rolledNumber]]);
        urBoard.boardMap[track[currentPlayer][i]].canMove = true;
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
        hasPiece[getOpponent()](track[indexDestiny])) {
      return false;
    }

    return true;
  }

  int getOpponent() => currentPlayer == 1 ? 2 : 1;

  void movePiece(int trackIndex) {
    var fromTileName = track[currentPlayer][trackIndex];
    var destinyTileName = track[currentPlayer][trackIndex + rolledNumber];
    _movePiece[currentPlayer](fromTileName, destinyTileName);

    if(urBoard.boardMap[destinyTileName].isSpecial) {
      playAgain();
    } else {
      nextTurn();
    }
  }

  void playAgain() {
    hasRolledDice = false;
  }

  void nextTurn() {
    currentPlayer = getOpponent();
    hasRolledDice = false;

    if(currentPlayer == 2 && !playerTwoHuman) {
      playAITurn();
    }
  }

  void playAITurn() {
    rollDice();
    final moves = getAvailableMoves();

    if(moves.length > 0) {
      final tile = urBoard.boardMap[moves[Random().nextInt(moves.length)]];
      movePiece(tile.trackIndex);
      if(hasRolledDice == false) {
        playAITurn();
      }
    } else {
      nextTurn();
    }
  }

  Map<String, Tile> getBoardMap() => urBoard.boardMap;

  int rollDice() {
    final r = Random();
    rolledNumber = r.nextInt(1) + r.nextInt(1) + r.nextInt(1) + r.nextInt(1);
    hasRolledDice = true;
    return rolledNumber;
  }

  int getWinnerPlayer() {
    if(urBoard.boardMap['20'].playerOnePieces == 5) {
      return 1;
    } else {
      return 2;
    }
  }
}

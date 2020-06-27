import 'package:domain/models/tile.dart';
import 'package:flutter/widgets.dart';

abstract class GameStates {}

class Game implements GameStates {
  Game({
    @required this.boardMap,
    @required this.currentPlayer,
    @required this.hasRolledDice,
  });

  final Map<String, Tile> boardMap;
  final int currentPlayer;
  final bool hasRolledDice;
}

class GameOver implements GameStates {
  GameOver(this.winnerPlayer);

  final int winnerPlayer;
}

abstract class GameAction {}

class MovePieceGameAction implements GameAction {
  MovePieceGameAction(this.boardMap);

  final Map<String, Tile> boardMap;
}

class RollDiceGameAction implements GameAction {
  RollDiceGameAction(this.diceNumber);

  final int diceNumber;
}

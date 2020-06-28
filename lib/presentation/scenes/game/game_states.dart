import 'package:domain/models/tile.dart';
import 'package:flutter/widgets.dart';

abstract class GameStates {}

class Game implements GameStates {
  Game({
    @required this.boardMap,
    @required this.currentPlayer,
    @required this.hasRolledDice,
    this.rolledNumber,
  });

  final Map<String, Tile> boardMap;
  final int currentPlayer;
  final bool hasRolledDice;
  final int rolledNumber;
}

class GameOver implements GameStates {
  GameOver(this.winnerPlayer);

  final int winnerPlayer;
}

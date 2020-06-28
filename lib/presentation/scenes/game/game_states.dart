import 'package:domain/entities/ur_game.dart';
import 'package:domain/models/tile.dart';
import 'package:flutter/widgets.dart';

abstract class GameStates {}

class Game implements GameStates {
  Game({
    @required this.urGame,
    @required this.boardMap,
    @required this.currentPlayer,
    @required this.hasRolledDice,
    this.rolledNumber,
    this.canPlayerMove,
  });

  final Map<String, Tile> boardMap;
  final UrGame urGame;
  final int currentPlayer;
  final bool hasRolledDice;
  final int rolledNumber;
  final bool canPlayerMove;
}

class GameOver implements GameStates {
  GameOver(this.winnerPlayer);

  final int winnerPlayer;
}

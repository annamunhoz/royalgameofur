import 'dart:async';

import 'package:domain/entities/ur_game.dart';
import 'package:royalgameofur/presentation/scenes/game/game_states.dart';
import 'package:rxdart/rxdart.dart';

class GameBloc {
  GameBloc(this.urGame) : assert(urGame != null) {
    _subscription
      ..add(
        _gameState().listen(_onNewStateController.add),
      )
      ..add(
        Rx.merge([
          _onMovePieceController.stream,
        ]).flatMap(_clickToMove).listen(_onNewStateController.add),
      )
      ..add(
        Rx.merge([
          _onRollDiceController.stream,
        ]).flatMap(_rollDice).listen(_onNewStateController.add),
      )
      ..add(
        Rx.merge([
          _onPassTurnController.stream,
        ]).flatMap(_passTurn).listen(_onNewStateController.add),
      )
      ..add(
        Rx.merge([
          _onNewGameController.stream,
        ]).flatMap(_newGame).listen(_onNewStateController.add),
      );
  }

  final UrGame urGame;

  final _subscription = CompositeSubscription();

  final _onNewStateController = BehaviorSubject<GameStates>();
  Stream<GameStates> get onNewState => _onNewStateController.stream;

  final _onMovePieceController = BehaviorSubject<int>();
  Sink<int> get onMovePiece => _onMovePieceController.sink;

  final _onRollDiceController = BehaviorSubject<int>();
  Sink<int> get onRollDice => _onRollDiceController.sink;

  final _onPassTurnController = BehaviorSubject<int>();
  Sink<int> get onPassTurn => _onPassTurnController.sink;

  final _onNewGameController = BehaviorSubject<int>();
  Sink<int> get onNewGame => _onNewGameController.sink;

  Stream<GameStates> _gameState() async* {
    try {
      if (urGame.finished) {
        yield GameOver(urGame.getWinnerPlayer());
      } else {
        yield Game(
          boardMap: urGame.getBoardMap(),
          urGame: urGame,
          hasRolledDice: urGame.hasRolledDice,
          rolledNumber: urGame.rolledNumber,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Stream<GameStates> _clickToMove(trackIndex) async* {
    urGame.movePiece(trackIndex);

    if (urGame.finished) {
      yield GameOver(urGame.getWinnerPlayer());
    } else {
      yield Game(
        boardMap: urGame.getBoardMap(),
        urGame: urGame,
        hasRolledDice: urGame.hasRolledDice,
        rolledNumber: urGame.rolledNumber,
      );
    }
  }

  Stream<GameStates> _rollDice(_) async* {
    urGame.rollDice();

    if (urGame.finished) {
      yield GameOver(urGame.getWinnerPlayer());
    } else {
      yield Game(
        boardMap: urGame.getBoardMap(),
        urGame: urGame,
        hasRolledDice: urGame.hasRolledDice,
        rolledNumber: urGame.rolledNumber,
      );
    }
  }

  Stream<GameStates> _passTurn(_) async* {
    urGame.nextTurn();

    if (urGame.finished) {
      yield GameOver(urGame.getWinnerPlayer());
    } else {
      yield Game(
        boardMap: urGame.getBoardMap(),
        urGame: urGame,
        hasRolledDice: urGame.hasRolledDice,
        rolledNumber: urGame.rolledNumber,
      );
    }
  }

  Stream<GameStates> _newGame(_) async* {
    if (urGame.finished) {
      yield GameOver(urGame.getWinnerPlayer());
    } else {
      yield Game(
        boardMap: urGame.getBoardMap(),
        urGame: urGame,
        hasRolledDice: urGame.hasRolledDice,
        rolledNumber: urGame.rolledNumber,
      );
    }
  }

  void dispose() {
    _onNewStateController.close();
    _onMovePieceController.close();
    _onRollDiceController.close();
    _onPassTurnController.close();
    _onNewGameController.close();
  }
}

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
      );
//      ..add(
//        Rx.merge([
//          _onRollDiceController.stream,
//        ]).switchMap((_) => _rollDice).listen(_onNewStateController.add),
//      );
  }

  final UrGame urGame;

  final _subscription = CompositeSubscription();

  final _onNewStateController = BehaviorSubject<GameStates>();
  Stream<GameStates> get onNewState => _onNewStateController.stream;

  final _onMovePieceController = BehaviorSubject<int>();
  Sink<int> get onMovePiece => _onMovePieceController.sink;

  final _onRollDiceController = BehaviorSubject<void>();
  Sink<void> get onRollDice => _onRollDiceController.sink;

  Stream<GameStates> _gameState() async* {
    try {
      if (urGame.finished) {
        yield GameOver(urGame.getWinnerPlayer());
      } else {
        yield Game(
          boardMap: urGame.getBoardMap(),
          currentPlayer: urGame.currentPlayer,
          hasRolledDice: urGame.hasRolledDice,
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
        currentPlayer: urGame.currentPlayer,
        hasRolledDice: urGame.hasRolledDice,
      );
  }}

  Stream<GameStates> _rollDice() async* {
    urGame.rollDice();
  }

  void dispose() {
    _onNewStateController.close();
    _onMovePieceController.close();
    _onRollDiceController.close();
  }
}

extension AddToCompositeSubscriptionExtension<T> on StreamSubscription<T> {
  /// Adds this subscription to composite container for subscriptions.
  void addTo(CompositeSubscription compositeSubscription) =>
      compositeSubscription.add(this);
}

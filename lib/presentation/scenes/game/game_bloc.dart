import 'package:domain/entities/ur_game.dart';
import 'package:royalgameofur/presentation/scenes/game/game_states.dart';
import 'package:rxdart/rxdart.dart';

class GameBloc {
  GameBloc(this.urGame) : assert(urGame != null) {}

  final UrGame urGame;

  final _subscription = CompositeSubscription();

  final _onNewActionController = BehaviorSubject<GameAction>();
  Stream<GameAction> get onNewAction => _onNewActionController.stream;

  final _onNewStateController = BehaviorSubject<GameStates>();
  Stream<GameStates> get onNewState => _onNewStateController.stream;

  void dispose() {
    _onNewActionController.close();
    _onNewStateController.close();
  }
}

import 'package:domain/entities/ur_board.dart';
import 'package:domain/entities/ur_game.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:royalgameofur/presentation/scenes/game/game_bloc.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({
    @required this.child,
  }) : assert(child != null);

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<UrBoard>(create: (_) => UrBoard()),
          ProxyProvider<UrBoard, UrGame>(
            update: (context, urBoard, urGame) => UrGame(urBoard),
          ),
          ProxyProvider<UrGame, GameBloc>(
            update: (context, urGame, gameBloc) => GameBloc(urGame),
            dispose: (context, gameBloc) => gameBloc.dispose(),
          )
        ],
        child: child,
      );
}

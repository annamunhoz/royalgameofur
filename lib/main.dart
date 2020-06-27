import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royalgameofur/app_provider.dart';
import 'package:royalgameofur/presentation/scenes/game/game_bloc.dart';
import 'package:royalgameofur/presentation/scenes/game/game_page.dart';
import 'package:royalgameofur/presentation/home_page.dart';
import 'package:royalgameofur/presentation/scenes/game_rules/game_rules_page.dart';

void main() {
  runApp(
    AppProvider(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Royal Game of Ur',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: HomePage(),
        routes: {
          GamePage.routeName: (context) => Consumer<GameBloc>(
                builder: (context, gameBloc, _) => GamePage(gameBloc),
              ),
          GameRulesPage.routeName: (context) => GameRulesPage(),
        },
      );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royalgameofur/app_provider.dart';
import 'package:royalgameofur/presentation/common/app_colors.dart';
import 'package:royalgameofur/presentation/home_page.dart';
import 'package:royalgameofur/presentation/scenes/game/game_bloc.dart';
import 'package:royalgameofur/presentation/scenes/game/game_page.dart';
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
          backgroundColor: AppColors.backgroundGameColor,
          appBarTheme: AppBarTheme(
              color: AppColors.backgroundGameColor,
              textTheme: TextTheme(
                headline6: TextStyle(
                  fontFamily: 'VCR_OSD',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              )),
          textTheme: TextTheme(
              bodyText2: TextStyle(
                fontFamily: 'VCR_OSD',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.5,
              ),
              headline6: TextStyle(
                fontFamily: 'VCR_OSD',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.5,
              ),
              button: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: 'VCR_OSD',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        ),
        home: HomePage(),
        routes: {
          GamePage.routeName: (context) => Consumer<GameBloc>(
                builder: (context, gameBloc, _) {
                  final playerTwoIsHuman =
                      ModalRoute.of(context).settings.arguments;
                  gameBloc.urGame.newGame(playerTwoIsHuman);
                  return GamePage(gameBloc);
                },
              ),
          GameRulesPage.routeName: (context) => GameRulesPage(),
        },
      );
}

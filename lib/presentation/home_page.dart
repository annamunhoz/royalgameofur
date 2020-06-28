import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:royalgameofur/presentation/common/app_colors.dart';
import 'package:royalgameofur/presentation/scenes/game_rules/game_rules_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'scenes/game/game_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(20)),
              Container(
                  height: 150,
                  child: Image(image: AssetImage('assets/images/logo.gif'))),
              const Padding(padding: EdgeInsets.all(5)),
              const Text(
                'The Royal Game of Ur is the oldest boardgame ever.',
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(GameRulesPage.routeName),
                child: const Text('How to Play'),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              RaisedButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(GamePage.routeName, arguments: true),
                child: const Text('Play against Friend'),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              RaisedButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(GamePage.routeName, arguments: false),
                child: const Text('Play against AI'),
              ),
              const Spacer(),
              const Text(
                'Developed during the Flutter Hackathon 2020.',
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Wrap(
                      children: <Widget>[
                        FlatButton(
                          onPressed: _launchAnnaURL,
                          textColor: AppColors.playerOneColor,
                          child: Text(
                            'Contact Anna Munhoz',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: _launchViniciusURL,
                          textColor: AppColors.playerTwoColor,
                          child: Text(
                            'Contact Vinicius Munhoz',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(8))
            ],
          ),
        ),
        backgroundColor: AppColors.backgroundGameColor,
      );

  void _launchViniciusURL() async {
    const url = 'https://www.linkedin.com/in/vmunhoz/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchAnnaURL() async {
    const url = 'https://www.linkedin.com/in/annamunhoz/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

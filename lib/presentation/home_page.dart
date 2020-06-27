import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:royalgameofur/presentation/scenes/game_rules/game_rules_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'scenes/game/game_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Royal Game of Ur'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(18)),
              const Text(
                'The Royal Game of Ur is the oldest boardgame ever.',
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(18)),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(GameRulesPage.routeName),
                child: const Text('How to Play'),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(GamePage.routeName),
                child: const Text('Start a new Game'),
              ),
              const Spacer(),
              const Text(
                'Develop during the Flutter Hackathon 2020.',
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Wrap(
                      // TODO: Find a better way to show the link (está muito afastado)
                      children: <Widget>[
                        FlatButton(
                          onPressed: _launchAnnaURL,
                          child: const Text('Contact Anna Munhoz'),
                        ),
                        FlatButton(
                          onPressed: _launchViniciusURL,
                          child: const Text('Contact Vinicius Munhoz'),
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

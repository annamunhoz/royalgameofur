import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GamePage extends StatefulWidget {
  static const routeName = '/game';
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
    );
  }
}

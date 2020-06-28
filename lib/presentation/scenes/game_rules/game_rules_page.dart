import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:royalgameofur/presentation/common/app_colors.dart';

class GameRulesPage extends StatefulWidget {
  static const String routeName = '/game-rules';

  @override
  _GameRulesPageState createState() => _GameRulesPageState();
}

class _GameRulesPageState extends State<GameRulesPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return CarouselSlider(
      items: imageSliders,
      options: CarouselOptions(
          height: height * 0.9,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );
  }

  // TODO: update images
  static final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  ];

  final List<Widget> imageSliders = imgList
      .map(
        (item) => Material(
          color: AppColors.backgroundGameColor,
          child: Container(
            color: AppColors.playerOneColor,
            margin: const EdgeInsets.all(5),
            child: Stack(children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Text(
                    '${imgList.indexOf(item) + 1}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ]),
          ),
        ),
      )
      .toList();
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        Spacer(),
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              height: height * 0.9,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              aspectRatio: 2.0,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((image) {
            int index = imgList.indexOf(image);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(246, 0, 255, 0.9)
                    : Color.fromRGBO(246, 0, 255, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  static final List<String> imgList = [
    'assets/images/tutorial1.png',
    'assets/images/tutorial2.png',
    'assets/images/tutorial3.png',
    'assets/images/tutorial4.png',
  ];

  final List<Widget> imageSliders = imgList
      .map(
        (item) => Material(
          color: AppColors.backgroundGameColor,
          child: Container(
            color: AppColors.backgroundGameColor,
            child: Stack(children: <Widget>[
              Image.asset(
                item,
                fit: BoxFit.contain,
                width: 1000,
              ),
            ]),
          ),
        ),
      )
      .toList();
}

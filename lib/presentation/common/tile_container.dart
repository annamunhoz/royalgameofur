import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TileContainer extends StatelessWidget {
  const TileContainer({
    this.isSpecial = false,
    this.child,
    this.background = true,
    this.canMove = false,
  });

  final bool isSpecial;
  final Widget child;
  final bool background;
  final bool canMove;

  @override
  Widget build(BuildContext context) {
    final dataDevice = MediaQuery.of(context);
    BoxDecoration decoration = null;

    final specialName = isSpecial ? '_special' : '';
    final canMoveName = canMove ? '_canMove' : '';
    final tileImageName = 'assets/images/tile${specialName}${canMoveName}.png';

    if (background) {
      decoration = BoxDecoration(
          image: DecorationImage(
              image: AssetImage(tileImageName),
              fit: BoxFit.fill));
    }

    return Container(
      height: dataDevice.size.height * 0.09375,
      width: dataDevice.size.width * 0.3,
      decoration: decoration,
      child: child,
    );
  }
}

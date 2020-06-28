import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TileContainer extends StatelessWidget {
  const TileContainer({
    this.isSpecial = false,
    this.child,
    this.background = true,
  });

  final bool isSpecial;
  final Widget child;
  final bool background;

  @override
  Widget build(BuildContext context) {
    final dataDevice = MediaQuery.of(context);
    BoxDecoration decoration = null;

    if (background) {
      decoration = BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isSpecial
                  ? 'assets/images/tile_special.png'
                  : 'assets/images/tile.png'),
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

import 'package:flutter/widgets.dart';

class TileContainer extends StatelessWidget {
  const TileContainer({
    this.color,
    this.child,
  });

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dataDevice = MediaQuery.of(context);

    return Container(
      height: dataDevice.size.height * 0.09375,
      width: dataDevice.size.width * 0.3,
      color: color,
      child: child,
    );
  }
}

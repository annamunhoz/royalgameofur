import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:royalgameofur/presentation/common/app_colors.dart';

class PlayerPiece extends StatelessWidget {
  const PlayerPiece({
    @required this.player,
    this.quantityPiece,
  }) : assert(player != null && player < 3 && player > 0);

  final int player;
  final String quantityPiece;

  @override
  Widget build(BuildContext context) {
    final dataDevice = MediaQuery.of(context);
    final playerColor =
        player == 1 ? AppColors.playerOneColor : AppColors.playerTwoColor;

    return Column(
      children: <Widget>[
        Container(
          height: dataDevice.size.height * 0.09375,
          width: dataDevice.size.height * 0.060,
          decoration: BoxDecoration(
            color: playerColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              quantityPiece ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

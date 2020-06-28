import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:royalgameofur/presentation/common/app_colors.dart';

class PlayerStartingPieces extends StatelessWidget {
  const PlayerStartingPieces({
    @required this.player,
    @required this.canMove,
    this.quantityPiece,
  }) : assert(player != null && player < 3 && player > 0);

  final int player;
  final int quantityPiece;
  final bool canMove;

  @override
  Widget build(BuildContext context) {
    player == 1 ? AppColors.playerOneColor : AppColors.playerTwoColor;

    BoxDecoration decoration = null;
    if (canMove) {
      decoration = BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/initial_canMove.png'),
              fit: BoxFit.fill));
    }

    return Container(
      decoration: decoration,
      child: FittedBox(
        child: Image.asset('assets/images/p${player}-${quantityPiece}.png'),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

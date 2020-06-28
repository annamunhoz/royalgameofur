import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:royalgameofur/presentation/common/app_colors.dart';

class PlayerStartingPieces extends StatelessWidget {
  const PlayerStartingPieces({
    @required this.player,
    this.quantityPiece,
  }) : assert(player != null && player < 3 && player > 0);

  final int player;
  final String quantityPiece;

  @override
  Widget build(BuildContext context) {
    player == 1 ? AppColors.playerOneColor : AppColors.playerTwoColor;

    return FittedBox(
      child: Image.asset('assets/images/p${player}-${quantityPiece}.png'),
      fit: BoxFit.fitWidth,
    );
  }
}
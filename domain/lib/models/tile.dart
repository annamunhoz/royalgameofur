import 'package:meta/meta.dart';

class Tile {
  Tile({
    @required this.trackIndex,
    this.playerOnePieces = 0,
    this.playerTwoPieces = 0,
    this.isSpecial = false,
    this.canMove = false,
  })  : assert(playerOnePieces != null),
        assert(playerTwoPieces != null),
        assert(isSpecial != null);

  final int trackIndex;
  final bool isSpecial;
  int playerOnePieces;
  int playerTwoPieces;
  bool canMove;
}

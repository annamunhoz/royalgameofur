class Tile {
  Tile({
    this.playerOnePieces = 0,
    this.playerTwoPieces = 0,
    this.isSpecial = false,
  })  : assert(playerOnePieces != null),
        assert(playerTwoPieces != null),
        assert(isSpecial != null);

  int playerOnePieces;
  int playerTwoPieces;
  final bool isSpecial;
}

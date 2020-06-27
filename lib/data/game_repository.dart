import 'package:domain/data/game_data_repository.dart';

import 'models/tile.dart';

class GameRepository implements GameDataRepository {
  Map<String, Tile> getBoard() {
    final Tile genericTile = Tile();

    final Tile specialTile = Tile(
      isSpecial: true,
    );

    final Tile p1InitialTile = Tile(
      playerOnePieces: 5,
    );

    final Tile p2InitialTile = Tile(
      playerTwoPieces: 5,
    );

    return {
      '00': genericTile,
      '01': genericTile,
      '02': genericTile,
      '10': specialTile,
      '11': genericTile,
      '12': specialTile,
      '20': Tile(playerOnePieces: 3),
      '21': genericTile,
      '22': Tile(playerTwoPieces: 2),
      '30': p1InitialTile,
      '31': genericTile,
      '32': p2InitialTile,
      '40': genericTile,
      '41': specialTile,
      '42': genericTile,
      '50': genericTile,
      '51': genericTile,
      '52': Tile(playerTwoPieces: 1),
      '60': genericTile,
      '61': genericTile,
      '62': genericTile,
      '70': specialTile,
      '71': genericTile,
      '72': specialTile,
    };
  }
}

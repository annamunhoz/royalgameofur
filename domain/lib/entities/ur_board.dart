import 'package:domain/models/tile.dart';

class UrBoard {
  UrBoard() {
    initializeBoard();
  }

  List<String> playerOneTrack;
  List<String> playerTwoTrack;
  Map<String, Tile> boardMap;

  void initializeBoard() {
    playerOneTrack = <String>[
      '30',
      '40',
      '50',
      '60',
      '70',
      '71',
      '61',
      '51',
      '41',
      '31',
      '21',
      '11',
      '01',
      '00',
      '10',
      '20'
    ];
    playerTwoTrack = <String>[
      '32',
      '42',
      '52',
      '62',
      '72',
      '71',
      '61',
      '51',
      '41',
      '31',
      '21',
      '11',
      '01',
      '02',
      '12',
      '22'
    ];

    boardMap = {
      '00': Tile(),
      '01': Tile(),
      '02': Tile(),
      '10': Tile(isSpecial: true),
      '11': Tile(),
      '12': Tile(isSpecial: true),
      '20': Tile(),
      '21': Tile(),
      '22': Tile(),
      '30': Tile(playerOnePieces: 5),
      '31': Tile(),
      '32': Tile(playerTwoPieces: 5),
      '40': Tile(),
      '41': Tile(isSpecial: true),
      '42': Tile(),
      '50': Tile(),
      '51': Tile(),
      '52': Tile(),
      '60': Tile(),
      '61': Tile(),
      '62': Tile(),
      '70': Tile(isSpecial: true),
      '71': Tile(),
      '72': Tile(isSpecial: true),
    };
  }

  void movePlayerOnePiece(String tileFrom, String tileDestiny) {
    boardMap[tileFrom].playerOnePieces -= 1;
    boardMap[tileDestiny].playerOnePieces += 1;
  }

  void movePlayerTwoPiece(String tileFrom, String tileDestiny) {
    boardMap[tileFrom].playerTwoPieces -= 1;
    boardMap[tileDestiny].playerTwoPieces += 1;
  }

  bool hasPlayerOnePiece(String tile) => boardMap[tile].playerOnePieces > 0;

  bool hasPlayerTwoPiece(String tile) => boardMap[tile].playerTwoPieces > 0;
}

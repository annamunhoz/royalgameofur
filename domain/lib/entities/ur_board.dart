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
      '00': Tile(trackIndex: 13),
      '01': Tile(trackIndex: 12),
      '02': Tile(trackIndex: 13),
      '10': Tile(isSpecial: true, trackIndex: 14),
      '11': Tile(trackIndex: 11),
      '12': Tile(isSpecial: true, trackIndex: 14),
      '20': Tile(trackIndex: 15),
      '21': Tile(trackIndex: 10),
      '22': Tile(trackIndex: 15),
      '30': Tile(playerOnePieces: 5, trackIndex: 0),
      '31': Tile(trackIndex: 9),
      '32': Tile(playerTwoPieces: 5, trackIndex: 0),
      '40': Tile(trackIndex: 1),
      '41': Tile(isSpecial: true, trackIndex: 8),
      '42': Tile(trackIndex: 1),
      '50': Tile(trackIndex: 2),
      '51': Tile(trackIndex: 7),
      '52': Tile(trackIndex: 2),
      '60': Tile(trackIndex: 3),
      '61': Tile(trackIndex: 6),
      '62': Tile(trackIndex: 3),
      '70': Tile(isSpecial: true, trackIndex: 4),
      '71': Tile(trackIndex: 5),
      '72': Tile(isSpecial: true, trackIndex: 4),
    };
  }

  void movePlayerOnePiece(String tileFrom, String tileDestiny) {
    boardMap[tileFrom].playerOnePieces -= 1;
    boardMap[tileDestiny].playerOnePieces += 1;

    if (boardMap[tileDestiny].playerTwoPieces > 0) {
      boardMap[tileDestiny].playerTwoPieces -= 1;
      boardMap['32'].playerTwoPieces += 1;
    }
  }

  void movePlayerTwoPiece(String tileFrom, String tileDestiny) {
    boardMap[tileFrom].playerTwoPieces -= 1;
    boardMap[tileDestiny].playerTwoPieces += 1;

    if (boardMap[tileDestiny].playerOnePieces > 0) {
      boardMap[tileDestiny].playerOnePieces -= 1;
      boardMap['30'].playerOnePieces += 1;
    }
  }

  bool hasPlayerOnePiece(String tile) => boardMap[tile].playerOnePieces > 0;

  bool hasPlayerTwoPiece(String tile) => boardMap[tile].playerTwoPieces > 0;
}

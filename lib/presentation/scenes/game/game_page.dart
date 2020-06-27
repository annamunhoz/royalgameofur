import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:royalgameofur/data/game_repository.dart';
import 'package:royalgameofur/data/models/tile.dart';
import 'package:royalgameofur/presentation/common/app_colors.dart';
import 'package:royalgameofur/presentation/common/player_piece.dart';
import 'package:royalgameofur/presentation/common/tile_container.dart';

import 'game_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage(this.bloc) : assert(bloc != null);

  final GameBloc bloc;

  static const routeName = '/game';

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    final dataDevice = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundGameColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: dataDevice.size.height * 0.05,
        ),
        child: Column(
          children: <Widget>[
            Container(
                height: dataDevice.size.height * 0.85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _TileUI(_getBoard()['00']),
                        _TileUI(_getBoard()['01']),
                        _TileUI(_getBoard()['02']),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _TileUI(_getBoard()['10']),
                        _TileUI(_getBoard()['11']),
                        _TileUI(_getBoard()['12']),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _TilePoints(_getBoard()['20'], player: 1),
                        _TileUI(_getBoard()['21']),
                        _TilePoints(_getBoard()['22'], player: 2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _InitialTile(_getBoard()['30'], player: 1),
                        _TileUI(_getBoard()['31']),
                        _InitialTile(_getBoard()['32'], player: 2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _TileUI(_getBoard()['40']),
                        _TileUI(_getBoard()['41']),
                        _TileUI(_getBoard()['42']),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _TileUI(_getBoard()['50']),
                        _TileUI(_getBoard()['51']),
                        _TileUI(_getBoard()['52']),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _TileUI(_getBoard()['60']),
                        _TileUI(_getBoard()['61']),
                        _TileUI(_getBoard()['62']),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _TileUI(_getBoard()['70']),
                        _TileUI(_getBoard()['71']),
                        _TileUI(_getBoard()['72']),
                      ],
                    ),
                  ],
                )),
            Container(
              color: Colors.white,
              height: dataDevice.size.height * 0.10,
            ),
          ],
        ),
      ),
    );
  }

  Map<String, Tile> _getBoard() {
    final rep = GameRepository();
    return rep.getBoard();
  }
}

class _TileUI extends StatelessWidget {
  const _TileUI(this.tile) : assert(tile != null);

  final Tile tile;

  @override
  Widget build(BuildContext context) => TileContainer(
        color: tile.isSpecial
            ? AppColors.lightTileGameColor
            : AppColors.darkTileGameColor,
        child: tile.playerOnePieces != 0 || tile.playerTwoPieces != 0
            ? PlayerPiece(
                player: tile.playerOnePieces == 1 ? 1 : 2,
              )
            : null,
      );
}

class _TilePoints extends StatelessWidget {
  const _TilePoints(
    this.tile, {
    @required this.player,
  })  : assert(tile != null),
        assert(player != null && player < 3 && player > 0);

  final Tile tile;
  final int player;

  @override
  Widget build(BuildContext context) {
    final playerPoints = player == 1
        ? tile.playerOnePieces.toString()
        : tile.playerTwoPieces.toString();

    return TileContainer(
      child: Center(
        child: Text(
          playerPoints,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class _InitialTile extends StatelessWidget {
  const _InitialTile(
    this.tile, {
    @required this.player,
  })  : assert(tile != null),
        assert(player != null && player < 3 && player > 0);

  final Tile tile;
  final int player;

  @override
  Widget build(BuildContext context) {
    final playerPieces = player == 1
        ? tile.playerOnePieces.toString()
        : tile.playerTwoPieces.toString();

    return TileContainer(
      child: PlayerPiece(
        quantityPiece: playerPieces,
        player: player,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:royalgameofur/presentation/common/app_colors.dart';
import 'package:royalgameofur/presentation/common/player_piece.dart';
import 'package:royalgameofur/presentation/common/player_starting_pieces.dart';
import 'package:royalgameofur/presentation/common/tile_container.dart';
import 'package:royalgameofur/presentation/scenes/game/game_states.dart';
import 'package:domain/models/tile.dart';

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
        child: StreamBuilder<GameStates>(
            stream: widget.bloc.onNewState,
            builder: (context, snapshot) {
              final snapshotData = snapshot.data;

              if (snapshotData is GameOver) {
                return _GameOver(snapshotData.winnerPlayer);
              }
              if (snapshotData is Game) {
                return Column(
                  children: <Widget>[
                    Container(
                        height: dataDevice.size.height * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _TileUI(
                                    snapshotData.boardMap['00'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['01'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['02'], widget.bloc),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _TileUI(
                                    snapshotData.boardMap['10'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['11'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['12'], widget.bloc),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _TilePoints(snapshotData.boardMap['20'],
                                    player: 1),
                                _TileUI(
                                    snapshotData.boardMap['21'], widget.bloc),
                                _TilePoints(snapshotData.boardMap['22'],
                                    player: 2),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _InitialTile(snapshotData.boardMap['30'],
                                    player: 1),
                                _TileUI(
                                    snapshotData.boardMap['31'], widget.bloc),
                                _InitialTile(snapshotData.boardMap['32'],
                                    player: 2),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _TileUI(
                                    snapshotData.boardMap['40'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['41'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['42'], widget.bloc),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _TileUI(
                                    snapshotData.boardMap['50'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['51'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['52'], widget.bloc),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _TileUI(
                                    snapshotData.boardMap['60'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['61'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['62'], widget.bloc),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _TileUI(
                                    snapshotData.boardMap['70'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['71'], widget.bloc),
                                _TileUI(
                                    snapshotData.boardMap['72'], widget.bloc),
                              ],
                            ),
                          ],
                        )),
                    Container(
                      color: Colors.white,
                      height: dataDevice.size.height * 0.10,
                    ),
                  ],
                );
              }
              return Container();
            }),
      ),
    );
  }
}

class _TileUI extends StatelessWidget {
  const _TileUI(this.tile, this.bloc) : assert(tile != null);

  final Tile tile;
  final GameBloc bloc;

  @override
  Widget build(BuildContext context) => tile.canMove
      ? GestureDetector(
          // TODO: add canMove to show different view
          onTap: () => bloc.onMovePiece.add(tile.trackIndex),
          child: TileContainer(
            isSpecial: tile.isSpecial,
            child: tile.playerOnePieces != 0 || tile.playerTwoPieces != 0
                ? PlayerPiece(
                    player: tile.playerOnePieces == 1 ? 1 : 2,
                  )
                : null,
          ),
        )
      : TileContainer(
          isSpecial: tile.isSpecial,
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
      background: false,
      child: Center(
          child: Column(
        children: <Widget>[
          Text(
            playerPoints,
            style: TextStyle(
              fontFamily: 'VCR_OSD',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
          Text(
            'P${player} POINTS',
            style: TextStyle(
              fontFamily: 'VCR_OSD',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      )),
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
      background: false,
      child: PlayerStartingPieces(
        quantityPiece: playerPieces,
        player: player,
      ),
    );
  }
}

class _GameOver extends StatelessWidget {
  const _GameOver(this.winnerPlayer, {Key key}) : super(key: key);

  final int winnerPlayer;

  @override
  Widget build(BuildContext context) => Container(
        color: AppColors.backgroundGameColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'The winner is \nPlayer $winnerPlayer',
                style: TextStyle(
                  fontFamily: 'VCR_OSD',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
              const Padding(
                padding: EdgeInsets.all(8),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                color: winnerPlayer == 1
                    ? AppColors.playerOneColor
                    : AppColors.playerTwoColor,
                child: Text(
                  'Play Again',
                  style: TextStyle(
                    fontFamily: 'VCR_OSD',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
}

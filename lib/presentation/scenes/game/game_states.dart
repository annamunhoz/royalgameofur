abstract class GameStates {}

class Game implements GameStates {}

class GameOver implements GameStates {}

abstract class GameAction {}

class MovePieceGameAction implements GameAction {}

class RollDiceGameAction implements GameAction {}

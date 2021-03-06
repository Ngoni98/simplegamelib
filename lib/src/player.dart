library simplegamelib.player;

import 'collectible.dart';
import 'sprite.dart';

/// Active agent taking part in the game.
class Player {
  Sprite sprite;
  int _score;
  int _health;
  int _lives;
  int _respawnCount;

  int get health => _health;

  int get score => _score;

  int get lives => _lives;

  set health(int newHealth) {
    _health = newHealth;
    update();
  }

  set score(int newScore) {
    _score = newScore;
    update();
  }

  set lives(int newLives) {
    _lives = newLives;
    update();
  }

  set respawnCount(int newRc) {
    _respawnCount = newRc;
  }

  String name;
  Function _updateNotification;

  /// Default constructor.
  Player() {
    reset();
  }

  /// Constructor that allows setting of update notifications.
  /// For example, a score display.
  Player.withNotifications(Function updateNotification) {
    reset();
    _updateNotification = updateNotification;
  }

  /// Standard initialisation.
  void reset() {
    health = 100;
    score = 0;
    name = "Player1";
    lives = 3;
    respawnCount = 100;
  }

  /// Updates and notifies of changes to properties
  void update() {
    if (_updateNotification != null) _updateNotification(this);
  }

  /// Alive flag taken from [Sprite].
  bool get alive => sprite.alive;

  /// Apply [Collectible] object to this player
  apply(Collectible powerUp) {
    score += powerUp.scoreDelta;
    health += powerUp.healthDelta;
  }

  ///
  isReadyToRespawn() {
    if (_respawnCount < 1) {
      _respawnCount = 100;
      health = 100;
      return true;
    }
    _respawnCount -= 1;
    return false;
  }
}

/**
 * This is an example of how to set up the [EventBus] and its events.
 */
import 'package:event_bus/event_bus.dart';

/// The global [EventBus] object.
EventBus eventBus = EventBus();

/* 
PuzzleScrenn will emit this event and PuzzleTile will listen for this event to move the tile.
*/
class MakeMoveEvent {
  //String keyPressed;
  int targetTileId;
  String direction;

  MakeMoveEvent(this.targetTileId, this.direction);

  String get getDirection {
    return direction;
  }
}

class MoveCompletedEvent {
  String text;

  MoveCompletedEvent(this.text);
}

class TileTappedEvent {
  int tileId;
  TileTappedEvent(this.tileId);
}

class GameStartEvent {}

class GameCompletedEvent {}

class UpdateScoreEvent {
  int tilesCompleted;
  int totalMoves;
  UpdateScoreEvent(this.tilesCompleted, this.totalMoves);
}

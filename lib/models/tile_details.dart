class TileMoveDetails {
  int eventTileXPos, eventTileYPos, eventTileValue, eventTileId;
  int blankTileXPos, blankTileYPos, blankTileId, blankTileValue;
  String eventTileMoveDirection, blankTileMoveDirection;

  TileMoveDetails(
      this.eventTileId,
      this.eventTileValue,
      this.eventTileXPos,
      this.eventTileYPos,
      this.eventTileMoveDirection,
      this.blankTileId,
      this.blankTileValue,
      this.blankTileXPos,
      this.blankTileYPos,
      this.blankTileMoveDirection);

  int get event_TileId {
    return eventTileId;
  }

  int get event_TileValue {
    return eventTileValue;
  }

  int get event_TileXPos {
    return eventTileXPos;
  }

  int get event_TileYPos {
    return eventTileYPos;
  }

  String get event_TileMoveDirection {
    return eventTileMoveDirection;
  }

  int get blank_TileId {
    return blankTileId;
  }

  int get blank_TileValue {
    return blankTileValue;
  }

  int get blank_TileXPos {
    return blankTileXPos;
  }

  int get blank_TileYPos {
    return blankTileYPos;
  }

  String get blank_TileMoveDirection {
    return blankTileMoveDirection;
  }

  @override
  String toString() {
    return " eventTileId: " +
        this.eventTileId.toString() +
        " eventTileValue: " +
        this.eventTileValue.toString() +
        " eventTileXPos: " +
        this.eventTileXPos.toString() +
        " eventTileYPos: " +
        this.eventTileYPos.toString() +
        " eventTileMoveDirection: " +
        this.eventTileMoveDirection.toString() +
        " blankTileId: " +
        this.blankTileId.toString() +
        " blankTileValue: " +
        this.blankTileValue.toString() +
        " blankTileXPos: " +
        this.blankTileXPos.toString() +
        " blankTileYPos: " +
        this.blankTileYPos.toString() +
        " blankTileMoveDirection: " +
        this.blankTileMoveDirection.toString();
  }
}

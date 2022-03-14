import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';
import 'package:circuit_slide/models/tile_details.dart';
import 'package:circuit_slide/constants/constants.dart' as constants;

class PuzzleProcessor {
  int puzzleRows = 4;
  int puzzleColumns = 4;

  int startNumber = 1;
  int blankTileValue = 16;
  late List solvedPuzzleArray;
  late List shuffledPuzzleArray;

  PuzzleProcessor() {
    // Initialize the 4 x 4 array with 1 to 16 values
    solvedPuzzleArray = List.generate(
        puzzleRows, (i) => List.generate(puzzleColumns, (j) => startNumber++));
    // Create another copy of the solved Puzzle, Initialize the 4 x 4 array with 1 to 16 values for
    startNumber = 1;
    shuffledPuzzleArray = List.generate(
        puzzleRows, (x) => List.generate(puzzleColumns, (y) => startNumber++));
  }

  printPuzzleArrayValues() {
    for (var row = 0; row < puzzleRows; row += 1) {
      for (var column = 0; column < puzzleColumns; column += 1) {
        print(solvedPuzzleArray[row]![column]);
        //print(puzzleArray);
      }
    }
  }

  printArrayValues(List? array) {
    for (var row = 0; row < puzzleRows; row++) {
      print(array![row]);
    }
  }

  Tuple2<int, int> getIndexPositions(int searchValue) {
    int xPos = -1, yPos = -1;
    // Loop through the shuffledPuzzleArray and index positions of searched value
    for (var row = 0; row < puzzleRows; row += 1) {
      for (var column = 0; column < puzzleColumns; column += 1) {
        if (shuffledPuzzleArray[row][column] == searchValue) {
          xPos = row;
          yPos = column;
        }
      }
    }
    return Tuple2(xPos, yPos);
  }

  Tuple4<int, int, int, int> getSurroundingValues(int xPos, yPos) {
    int upValue = -1, rightValue = -1, downValue = -1, leftValue = -1;

    if (xPos > 0 && xPos <= puzzleRows - 1) {
      // Get value from the previos row in the same column
      upValue = shuffledPuzzleArray[xPos - 1][yPos];
    }

    if (xPos >= 0 && xPos < puzzleRows - 1) {
      // Get value from the next row in the same column
      downValue = shuffledPuzzleArray[xPos + 1][yPos];
    }

    if (yPos >= 0 && yPos < puzzleColumns - 1) {
      // Get value from the next column in the same row
      rightValue = shuffledPuzzleArray[xPos][yPos + 1];
    }

    if (yPos > 0 && yPos <= puzzleColumns - 1) {
      // Get value from the previous column in the same row
      leftValue = shuffledPuzzleArray[xPos][yPos - 1];
    }

    return Tuple4(upValue, rightValue, downValue, leftValue);
  }

  int getRandomPosition() {
    int randomPosition = 4;
    //Generate Random number betwee 0 to 3. Additional check is required to ensure that the random number is not 4.
    randomPosition = Random().nextInt(4);
    while (randomPosition >= 4) {
      randomPosition = Random().nextInt(4);
    }
    return randomPosition;
  }

  List? getSolvedPuzzle() {
    return solvedPuzzleArray;
  }

  List? getShuffledPuzzle() {
    for (int i = 0; i < constants.kPuzzleShuffleCount; i++) {
      int valueAtRandomIndex = -1;
      int randomPosition = 4;

      //find current x,y index position of number 16(blank)
      Tuple2 blankIndex = getIndexPositions(blankTileValue);

      // Get all values at index positions surrounding position of 16(blank)
      Tuple4 surroundingValues =
          getSurroundingValues(blankIndex.item1, blankIndex.item2);

      // From the surrounding values get a valid value from a random direction (up, right, down, left )
      // This will be the value that will be swapped with the 16(blank) value
      while (valueAtRandomIndex <= 0) {
        valueAtRandomIndex =
            surroundingValues.toList().elementAt(getRandomPosition());
      }

      //find current x,y index position of the target value that will be swapped.
      Tuple2 targetValueIndex = getIndexPositions(valueAtRandomIndex);

      //Swap values in the shuffledPuzzleArray. Copy value at blankIndex in temp variable
      int tempValue = shuffledPuzzleArray[blankIndex.item1][blankIndex.item2];
      shuffledPuzzleArray[blankIndex.item1][blankIndex.item2] =
          valueAtRandomIndex;
      // Copy value 16(blank) to the target Index position
      shuffledPuzzleArray[targetValueIndex.item1][targetValueIndex.item2] =
          tempValue;
    }

    return shuffledPuzzleArray;
  }

  List? getUpdatedPuzzle() {
    return shuffledPuzzleArray;
  }

  bool isPuzzleSolved() {
    if (solvedPuzzleArray.toString() == shuffledPuzzleArray.toString()) {
      return true;
    } else {
      return false;
    }
  }

  bool isKeyPressedValid(String keyCode) {
    bool isKeyValid = false;

    //find current x,y index position of number 16(blank)
    Tuple2 blankIndex = getIndexPositions(blankTileValue);

    switch (keyCode) {
      case "Arrow Up":
        // Check if the blank slide is not in last row
        if (blankIndex.item1 < puzzleRows - 1) {
          isKeyValid = true;
        }
        break;
      case "Arrow Down":
        // Check if the blank slide is not in first row
        if (blankIndex.item1 > 0) {
          isKeyValid = true;
        }
        break;
      case "Arrow Left":
        // Check if the blank slide is not in last column
        if (blankIndex.item2 < puzzleColumns - 1) {
          isKeyValid = true;
        }
        break;
      case "Arrow Right":
        // Check if the blank slide is not in first column
        if (blankIndex.item2 > 0) {
          isKeyValid = true;
        }
        break;
    }
    return isKeyValid;
  }

  bool isTapEventValid(int eventTileId) {
    bool isTapEventValid = false;

    // If there is space in any of the surrounding values of the tapped tile
    //then the tap/click event is valid

    //find current x,y index position of the tapped tile
    Tuple2 tappedTileIndex = getIndexPositions(eventTileId);

    // Get all surrounding value of the tapped tile
    Tuple4 surroundingValues =
        getSurroundingValues(tappedTileIndex.item1, tappedTileIndex.item2);
    // Check if any of the surrounding value contains blank tile (16)
    isTapEventValid = surroundingValues.toList().contains(16);

    return isTapEventValid;
  }

  TileMoveDetails getNextMoveDetails(
      {String eventType = "", String keyCode = "", int tappedTileId = -1}) {
    late int eventTileXPos, eventTileYPos, eventTileValue, eventTileId;
    late int blankTileXPos, blankTileYPos, blankTileId;
    late String eventTileMoveDirection, blankTileMoveDirection;

    Tuple2 eventTileIndex;

    //find current x,y index position of number 16(blank tile)
    Tuple2 blankIndex = getIndexPositions(blankTileValue);
    blankTileXPos = blankIndex.item1;
    blankTileYPos = blankIndex.item2;

    // Get all values at index positions surrounding position of 16(blank)
    Tuple4 surroundingValues =
        getSurroundingValues(blankIndex.item1, blankIndex.item2);

    // If the event is generated from mouse click or tap then based on in which
    //direction the matching value is found, convert this into key board event
    if (eventType == "TAP" || eventType == "CLICK") {
      eventTileId = tappedTileId;

      if (surroundingValues.item1 == eventTileId) {
        keyCode = "Arrow Down";
      } else if (surroundingValues.item2 == eventTileId) {
        keyCode = "Arrow Left";
      } else if (surroundingValues.item3 == eventTileId) {
        keyCode = "Arrow Up";
      } else if (surroundingValues.item4 == eventTileId) {
        keyCode = "Arrow Right";
      }
    }
    // print("-----surrounding values----------");
    // print(surroundingValues);
    // print("---------------");

    // Based on the Key code pressed get the required value from the surrounding
    // position and set the movement direction for the event tile and blank tile
    // in opposite direction
    switch (keyCode) {
      case "Arrow Up":
        eventTileValue = surroundingValues.item3;
        eventTileMoveDirection = "UP";
        blankTileMoveDirection = "DOWN";
        break;
      case "Arrow Down":
        eventTileValue = surroundingValues.item1;
        eventTileMoveDirection = "DOWN";
        blankTileMoveDirection = "UP";
        break;
      case "Arrow Left":
        eventTileValue = surroundingValues.item2;
        eventTileMoveDirection = "LEFT";
        blankTileMoveDirection = "RIGHT";
        break;
      case "Arrow Right":
        eventTileValue = surroundingValues.item4;
        eventTileMoveDirection = "RIGHT";
        blankTileMoveDirection = "LEFT";
        break;
    }
    // For now Id of any tile is the text displayed on the tile
    eventTileId = eventTileValue;
    blankTileId = blankTileValue;

    // Get matrix coordintes for the event tile
    eventTileIndex = getIndexPositions(eventTileValue);
    eventTileXPos = eventTileIndex.item1;
    eventTileYPos = eventTileIndex.item2;

    // Return Move Details
    return TileMoveDetails(
        eventTileId,
        eventTileValue,
        eventTileXPos,
        eventTileYPos,
        eventTileMoveDirection,
        blankTileId,
        blankTileValue,
        blankTileXPos,
        blankTileYPos,
        blankTileMoveDirection);
  }

  swapValuesInShuffledPuzzle(TileMoveDetails tileMoveDetails) {
    // Assign current value of the event tile to the index of blank tile in the matrix
    shuffledPuzzleArray[tileMoveDetails.blankTileXPos]
        [tileMoveDetails.blankTileYPos] = tileMoveDetails.eventTileValue;
    // Assign current value of the blank tile to the index of the event tile in the matrix
    shuffledPuzzleArray[tileMoveDetails.eventTileXPos]
        [tileMoveDetails.eventTileYPos] = tileMoveDetails.blankTileValue;
  }

  int getTilesCompleted() {
    int tilesCompleted = 0;
    int numSequence = 1;
    // Loop through the shuffledPuzzleArray and check for sequence
    for (var row = 0; row < puzzleRows; row++) {
      for (var column = 0; column < puzzleColumns; column += 1) {
        if (shuffledPuzzleArray[row][column] == numSequence) {
          tilesCompleted++;
        } else {
          break;
        }
        numSequence++;
      }
    }

    return tilesCompleted;
  }
}

void main() {
  PuzzleProcessor pp = PuzzleProcessor();
  pp.printArrayValues(pp.getShuffledPuzzle());

  /*
  if (pp.isPuzzleSolved() == true) {
    print("Puzzle Solved");
  } else {
    print("puzzle not solved");
  }

  for (int i = 0; i < 100; i++) {
    pp.getShuffledPuzzle();

    // if (pp.isPuzzleSolved() == true) {
    //   print("Puzzle Solved");
    // }
  }
  */

  //pp.printArrayValues(pp.solvedPuzzleArray);

  //final t = pp.getIndexPositions(16);
  //print(t.item1); // prints 'a'
  //print(t.item2); // prints '10'
  /*for (int i = 1; i <= 100; i++) {
    print("Random number " + Random().nextInt(4).toString());
  }*/
  /*
  for (int i = 1; i <= 16; i++) {
    Tuple2 searchIndex = pp.getIndexPositions(i);
    Tuple4 surroundingValues =
        pp.getSurroundingValues(searchIndex.item1, searchIndex.item2);
   print("Surrounding Values of " +
        i.toString() +
        " are " +
        surroundingValues.item1.toString() +
        " , " +
        surroundingValues.item2.toString() +
        " , " +
        surroundingValues.item3.toString() +
        " , " +
        surroundingValues.item4.toString());
  }*/
}

// ignore_for_file: prefer_final_fields, file_names

// class PuzzleProcessor {
//   List<List> _tilesMatrix = [
//     [1, 2, 3, 4],
//     [5, 6, 7, 8],
//     [9, 10, 11, 12],
//     [13, 14, 15],
//   ];

//   List<List> get getCurrentTilesMatrix {
//     return _tilesMatrix;
//   }
// }

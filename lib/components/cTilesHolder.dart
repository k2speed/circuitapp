// ignore_for_file: camel_case_types, must_be_immutable, unnecessary_this, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:event_bus/event_bus.dart';

import 'package:circuit_slide/constants/constants.dart' as constants;
import 'package:circuit_slide/components/cTile.dart';
import 'package:circuit_slide/models/puzzleProcessor.dart';
import 'package:circuit_slide/events.dart';
import 'package:circuit_slide/models/tile_details.dart';
import 'package:just_audio/just_audio.dart';

class cTilesHolder extends StatefulWidget {
  cTilesHolder({Key? key}) : super(key: key);

  @override
  _cTilesHolderState createState() => _cTilesHolderState();
}

class _cTilesHolderState extends State<cTilesHolder> {
  double startX = 5;
  double startY = 5;
  List<Widget> tiles = [];
  late PuzzleProcessor _puzzleProcessor;
  late List tilesMatrix;
  int totalMoves = 0;
  int lastKeyPressTime = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    _puzzleProcessor = PuzzleProcessor();
    tilesMatrix = _puzzleProcessor.getSolvedPuzzle()!;
    registerEvents();
    lastKeyPressTime = DateTime.now().millisecondsSinceEpoch;
    _buildPuzzleMatrix();
    super.initState();
  }

  registerEvents() {
    eventBus.on<TileTappedEvent>().listen((event) {
      _handleTapEvent(event.tileId);
      //print("Received TileTappedEvent" + event.tileId.toString());
    });

    eventBus.on<GameStartEvent>().listen((event) {
      tiles.clear();
      tilesMatrix = _puzzleProcessor.getShuffledPuzzle()!;
      _buildPuzzleMatrix();
      setState(() {
        //Reset Score Summary
        totalMoves = 0;
        eventBus.fire(
            UpdateScoreEvent(_puzzleProcessor.getTilesCompleted(), totalMoves));
        constants.kGameInProgress = true;
        constants.kGameFinished = false;
        constants.kInnerTilePadding = 1;
        _focusNode.previousFocus();
      });
    });
  }

  void _buildPuzzleMatrix() {
    // Iterates through the matrix, row by row, and creates a [cTile] widget based off of its values
    for (var rowIndex = 0; rowIndex < tilesMatrix.length; rowIndex++) {
      for (var colIndex = 0;
          colIndex < tilesMatrix[rowIndex].length;
          colIndex++) {
        tiles.add(
          cTile(
            xpos: (colIndex * constants.kTileWidth) +
                startX +
                (constants.kTileSpacing * colIndex),
            ypos: (rowIndex * constants.kTileHeight) +
                startY +
                (constants.kTileSpacing * rowIndex),
            tileText: tilesMatrix[rowIndex][colIndex].toString(),
            id: tilesMatrix[rowIndex][colIndex],
          ),
        );
      }
    }
  }

  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    //print(tiles.length);

    return RawKeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKey: _handleKeyBoardEvent2,
      child: Container(
        color: constants.kBackgroundColor,
        width: double.infinity,
        height: double.infinity,
        padding: MediaQuery.of(context).size.width < 1024
            ? EdgeInsets.only(
                top: 30,
                left: 30,
              )
            : EdgeInsets.only(top: 100),
        child: Stack(children: tiles),
      ),
    );
  }

  // Focus nodes need to be disposed.
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTapEvent(int tileId) {
    //Check if the event is valid
    bool isEventValid = _puzzleProcessor.isTapEventValid(tileId);
    if (isEventValid == true && constants.kGameInProgress == true) {
      _processEvent(eventType: "TAP", tappedTileId: tileId);
    }
  }

  void _handleKeyBoardEvent(RawKeyEvent event) {
    print("_handleKeyBoardEvent called : " + event.runtimeType.toString());

    // Bug: When hosted in firebase, the runtime value changes to minified:iC
    // hence additional condition is added.
    // For more reference https://www.androidbugfix.com/2021/11/rawkeydownevent-not-triggered-for.html
    if (event.runtimeType.toString() == 'RawKeyDownEvent' ||
        event.runtimeType.toString() == 'minified:iC') {
      String? _keyCode = event.logicalKey.keyLabel;
      //String? _keyCode = event.data.physicalKey.toString();
      //print(_keyCode);

      //print("Inside If  condition with _keycode as " + _keyCode);

      if ((_keyCode == "Arrow Up" ||
              _keyCode == "Arrow Down" ||
              _keyCode == "Arrow Left" ||
              _keyCode == "Arrow Right") &&
          constants.kGameInProgress == true) {
        // Check if the Key pressed is valid for the current state of Matrix
        bool isEventValid = _puzzleProcessor.isKeyPressedValid(_keyCode);

        if (isEventValid) {
          _processEvent(eventType: "KEY_PRESSED", keyCode: _keyCode);
        }
      }
    }
  }

  void _handleKeyBoardEvent2(RawKeyEvent event) {
    print("_handleKeyBoardEvent called : " + event.runtimeType.toString());

    int currentKeyPressTime = DateTime.now().millisecondsSinceEpoch;

    if (event.runtimeType.toString() == 'RawKeyDownEvent' ||
        event.data is RawKeyEventDataWeb &&
            currentKeyPressTime > lastKeyPressTime + 200) {
      lastKeyPressTime = currentKeyPressTime;
      String? _keyCode = event.logicalKey.keyLabel;

      print("Inside If  condition with _keycode as " + _keyCode);

      if ((_keyCode == "Arrow Up" ||
              _keyCode == "Arrow Down" ||
              _keyCode == "Arrow Left" ||
              _keyCode == "Arrow Right") &&
          constants.kGameInProgress == true) {
        // Check if the Key pressed is valid for the current state of Matrix
        bool isEventValid = _puzzleProcessor.isKeyPressedValid(_keyCode);

        if (isEventValid) {
          _processEvent(eventType: "KEY_PRESSED", keyCode: _keyCode);
        }
      }
    }
  }

  _processEvent(
      {String eventType = "", String keyCode = "", int tappedTileId = -1}) {
    // Get Move Details
    // TileMoveDetails tileMoveDetails =
    //     _puzzleProcessor.getMoveDetails(keyCode: _keyCode);

    TileMoveDetails tileMoveDetails = _puzzleProcessor.getNextMoveDetails(
        eventType: eventType, keyCode: keyCode, tappedTileId: tappedTileId);

    //print(tileMoveDetails.toString());

    // Swap values in Matrix
    _puzzleProcessor.swapValuesInShuffledPuzzle(tileMoveDetails);

    // Move event tile
    eventBus.fire(MakeMoveEvent(
        tileMoveDetails.eventTileId, tileMoveDetails.eventTileMoveDirection));
    // Move blank tile
    eventBus.fire(MakeMoveEvent(
        tileMoveDetails.blankTileId, tileMoveDetails.blankTileMoveDirection));

    // Update Score Summary
    eventBus.fire(
        UpdateScoreEvent(_puzzleProcessor.getTilesCompleted(), ++totalMoves));

    // Check if the Puzzle is completed successfully
    bool isPuzzleCompleted = _puzzleProcessor.isPuzzleSolved();

    // if puzzle is completed then stop timer, update puzzle status,
    //animate tiles to show circuit completed status, update global variables
    //print("isPuzzleCompleted:" + isPuzzleCompleted.toString());

    if (isPuzzleCompleted) {
      // Play Puzzle Completed Sound
      // final player = AudioPlayer();
      // player.setAsset('sounds/lightson.mp3');
      // player.play();
      // Update global Game progress variable to false
      constants.kGameInProgress = false;
      constants.kGameFinished = true;
      constants.kInnerTilePadding = 3;

      // Fire Game Completed Event
      eventBus.fire(GameCompletedEvent());
    } else {
      // Play tile move sound
      // final player = AudioPlayer();
      // player.setAsset('sounds/tilemove1.mp3');
      // player.play();
    }
  }
}

// ignore_for_file: must_be_immutable, camel_case_types, file_names, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:circuit_slide/constants/constants.dart' as constants;
import 'package:circuit_slide/events.dart';

class cTile extends StatefulWidget {
  // x-position, y-position, and the number to be displayed
  late double xpos;
  late double ypos;
  late String tileText;
  late int tileId;

  static double width = constants.kTileWidth;
  static double height = constants.kTileHeight;

  cTile({Key? key, double? xpos, double? ypos, String? tileText, int? id})
      : super(key: key) {
    this.xpos = xpos!;
    this.ypos = ypos!;
    this.tileText = tileText!;
    this.tileId = id!;
  }

  @override
  State<cTile> createState() => _cTileState();
}

class _cTileState extends State<cTile> {
  @override
  void initState() {
    registerEvents();
    super.initState();
  }

  registerEvents() {
    eventBus.on<MakeMoveEvent>().listen((event) {
      // print("Received MakeMoveEvent" + event.targetTileId.toString());

      /* Check if this move event is applicable to the current Instance of PuzzleTile */
      if (event.targetTileId == widget.tileId) {
        moveTile(event);
      }
    });

    eventBus.on<GameCompletedEvent>().listen((event) {
      setState(() {});
    });
  }

  moveTile(MakeMoveEvent event) {
    /* Set new screen X and Y cordinates and then call setState to start the animation */
    switch (event.direction) {
      case "UP":
        widget.ypos =
            widget.ypos - (constants.kTileHeight + constants.kTileSpacing);
        break;
      case "DOWN":
        widget.ypos =
            widget.ypos + (constants.kTileHeight + constants.kTileSpacing);
        break;
      case "LEFT":
        widget.xpos =
            widget.xpos - (constants.kTileWidth + constants.kTileSpacing);
        break;
      case "RIGHT":
        widget.xpos =
            widget.xpos + (constants.kTileWidth + constants.kTileSpacing);
        break;
    }
    setState(() {});
    //TODO Emit MoveCompleted Event
  }

  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).size.width);
    return AnimatedPositioned(
      duration: widget.tileText != '16'
          ? const Duration(milliseconds: 300)
          : const Duration(milliseconds: 0),
      curve: Curves.decelerate,
      left: widget.xpos,
      top: widget.ypos,
      child: GestureDetector(
        onTap: () => eventBus.fire(TileTappedEvent(widget.tileId)),
        child: Container(
          // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          color: constants.kSurfaceColor,
          //width: cTile.width,
          width: MediaQuery.of(context).size.width > 1200
              ? cTile.width
              : cTile.width * 1,
          //height: cTile.height,
          height: MediaQuery.of(context).size.width > 1200
              ? cTile.height
              : cTile.height * 1,
          child: Center(
              child: Stack(
            children: [
              widget.tileText != '16'
                  ? Image.asset(
                      'assets/images/${constants.kGameFinished ? 'lit' : 'unlit'}/${widget.tileId}o.png',
                      // scale: 0.58,
                      width: constants.kTileWidth - constants.kInnerTilePadding,
                      height:
                          constants.kTileHeight - constants.kInnerTilePadding,
                      fit: BoxFit.fill,
                    )
                  : Container(),
              AutoSizeText(
                widget.tileText != '16' ? widget.tileText : '',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: MediaQuery.of(context).size.width < 1024
                      ? constants.kTileBadgeSize - 10
                      : constants.kTileBadgeSize,
                  color: constants.kOnSurfaceColor,
                ),
              ),
            ],
          )),
          // child: Center(
          //   child: Text(widget.tileText, style: kTileNumberStyle),
          // ),
        ),
      ),
    );
  }
}

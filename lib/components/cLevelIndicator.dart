import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:circuit_slide/constants/constants.dart' as constants;
import 'package:circuit_slide/events.dart';

class cLevelIndicator extends StatefulWidget {
  const cLevelIndicator({
    Key? key,
  }) : super(key: key);

  @override
  State<cLevelIndicator> createState() => _cLevelIndicatorState();
}

class _cLevelIndicatorState extends State<cLevelIndicator> {
  @override
  void initState() {
    registerEvents();
    super.initState();
  }

  registerEvents() {
    eventBus.on<GameStartEvent>().listen((event) {
      setState(() {});
    });

    eventBus.on<GameCompletedEvent>().listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          'Level 1 - Parallel circuit  ',
          style: TextStyle(
            color: constants.kOnSurfaceColor,
            fontFamily: 'Monda',
            fontSize: 20,
          ),
          minFontSize: 10,
          maxLines: 1,
          //overflow: TextOverflow.ellipsis,
        ),
        if (constants.kGameFinished)
          Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.green[600],
                borderRadius: BorderRadius.circular(57),
              ),
              width: 40,
              child: Icon(
                Icons.check,
                color: constants.kSurfaceColor,
                size: 30,
              ))
      ],
    );
  }
}


      // children: [
      //   Text(
      //     'Level 1 - Parallel circuit  ',
      //     style: TextStyle(
      //       color: constants.kOnSurfaceColor,
      //       fontFamily: 'Monda',
      //       fontSize: 30,
      //     ),
      //   ),
        // if (constants.kGameFinished)
        //   Container(
        //       padding: EdgeInsets.zero,
        //       decoration: BoxDecoration(
        //         color: Colors.green[600],
        //         borderRadius: BorderRadius.circular(57),
        //       ),
        //       width: 60,
        //       child: Icon(
        //         Icons.check,
        //         color: constants.kSurfaceColor,
        //         size: 40,
        //       ))
      // ],
import 'package:flutter/material.dart';

import 'package:circuit_slide/constants/constants.dart' as constants;
import 'package:circuit_slide/components/cLogoScorekeeper.dart';
import 'package:circuit_slide/components/cPuzzle.dart';
import 'package:circuit_slide/components/cTimer.dart';
import 'package:circuit_slide/components/cLevelIndicator.dart';
import 'package:circuit_slide/components/cStartbutton.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: constants.kBackgroundColor,
      child: Column(
        children: [
          Flexible(
            flex: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 200,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: cLogoScoreKeeper(
                          tilesCompleted: 0,
                          moves: 0,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            cLevelIndicator(),
                            SizedBox(width: 50),
                            StartButton(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Center(child: cPuzzle()),
                ),
                // Flexible(
                //   flex: 0,
                //   child: Container(
                //     color: constants.kBackgroundColor,
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              color: constants.kBackgroundColor,
              child: GameTimer(),
            ),
          )
        ],
      ),
    );
  }
}

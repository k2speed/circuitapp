import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:circuit_slide/constants/constants.dart' as constants;

class PuzzleAppBarText extends StatelessWidget {
  const PuzzleAppBarText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          'Circuit',
          style: TextStyle(
            color: constants.kPrimaryColorVariant,
            fontFamily: 'Montserrat',
            fontSize: MediaQuery.of(context).size.width < 1024 ? 30 : 50,
            fontWeight: MediaQuery.of(context).size.width < 1024
                ? FontWeight.w800
                : FontWeight.w500,
            letterSpacing: 0.5,
          ),
          minFontSize: 18,
          maxLines: 1,
          //overflow: TextOverflow.ellipsis,
        ),
        AutoSizeText(
          'Slide',
          style: TextStyle(
            color: constants.kPrimaryColor,
            fontFamily: 'Montserrat',
            fontSize: MediaQuery.of(context).size.width < 1024 ? 30 : 50,
            fontWeight: MediaQuery.of(context).size.width < 1024
                ? FontWeight.w800
                : FontWeight.w500,
            letterSpacing: 0,
          ),
          minFontSize: 18,
          maxLines: 1,
          //overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

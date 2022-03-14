// ignore_for_file: unused_import, file_names, camel_case_types

import 'package:flutter/material.dart';

import 'package:circuit_slide/constants/constants.dart' as constants;
import 'package:circuit_slide/models/puzzleProcessor.dart';
import 'package:circuit_slide/components/cTilesHolder.dart';

class cPuzzle extends StatelessWidget {
  late PuzzleProcessor _puzzleProcessor;

  // Gets the current Matrix from the processor
  late List<List> tilesMatrix;

  cPuzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cTilesHolder();
  }
}

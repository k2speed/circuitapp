// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:circuit_slide/constants/constants.dart' as constants;
import 'package:circuit_slide/events.dart';
import 'package:circuit_slide/components/app_bar.dart';
import 'package:circuit_slide/layout/desktop_layout.dart';
import 'package:circuit_slide/layout/mobile_layout.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: constants.kAppbarElevation,
          backgroundColor: constants.kBackgroundColor,
          toolbarHeight: constants.kAppbarHeight,
          leading: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              'assets/circuitSlideLogoColored.svg',
              width: 20,
              height: 20,
            ),
          ),
          leadingWidth: constants.kAppbarLogoTypographySpacing,
          title: PuzzleAppBarText(),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 1024) {
              constants.kTileWidth = 120;
              constants.kTileHeight = 120;
              return DesktopLayout();
            } else {
              constants.kTileWidth = 80;
              constants.kTileHeight = 80;
              return MobileLayout();
            }
          },
        ),
      ),
    );
  }
}

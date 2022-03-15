// ignore_for_file: camel_case_types, must_be_immutable, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:circuit_slide/constants/constants.dart' as constants;
import 'package:circuit_slide/events.dart';

class cLogoScoreKeeper extends StatefulWidget {
  late int moves;
  late int tilesCompleted;

  cLogoScoreKeeper({Key? key, int? moves, int? tilesCompleted})
      : super(key: key) {
    this.moves = moves!;
    this.tilesCompleted = tilesCompleted!;
  }

  @override
  _cLogoScoreKeeperState createState() => _cLogoScoreKeeperState();
}

class _cLogoScoreKeeperState extends State<cLogoScoreKeeper> {
  StreamSubscription? subscriptionUpdateScoreEvent;
  @override
  void initState() {
    registerEvents();
    super.initState();
  }

  @override
  void dispose() async {
    subscriptionUpdateScoreEvent!.cancel();
    subscriptionUpdateScoreEvent = null;
    super.dispose();
  }

  registerEvents() {
    subscriptionUpdateScoreEvent =
        eventBus.on<UpdateScoreEvent>().listen((event) {
      widget.tilesCompleted = event.tilesCompleted;
      widget.moves = event.totalMoves;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width < 1024 ? false : true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isDesktop)
              AutoSizeText(
                'Circuit',
                style: TextStyle(
                  color: constants.kPrimaryColorVariant,
                  fontFamily: 'Oswald',
                  fontSize: 50,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 0.5,
                ),
                minFontSize: 18,
                maxLines: 1,
                //overflow: TextOverflow.ellipsis,
              ),
            if (isDesktop)
              const AutoSizeText(
                'Slide',
                style: TextStyle(
                  color: constants.kPrimaryColor,
                  fontFamily: 'Oswald',
                  fontSize: 50,
                  fontWeight: FontWeight.w100,
                  letterSpacing: 0.5,
                ),
                minFontSize: 18,
                maxLines: 1,
                //overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        if (isDesktop)
          SizedBox(
            width: 450,
            child: Divider(
              color: constants.kAccentColor,
              thickness: 6,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            AutoSizeText(
              (widget.moves).toString() + ' ',
              style: TextStyle(
                color: constants.kSecondaryColor,
                fontFamily: 'Monda',
                fontSize: 30,
              ),
              minFontSize: 18,
              maxLines: 1,
              //overflow: TextOverflow.ellipsis,
            ),
            AutoSizeText(
              'moves',
              style: TextStyle(
                color: constants.kSecondaryColorVariant,
                fontFamily: 'Monda',
                fontSize: 30,
              ),
              minFontSize: 18,
              maxLines: 1,
              //overflow: TextOverflow.ellipsis,
            ),
            AutoSizeText(
              ' | ',
              style: TextStyle(
                color: constants.kAccentColor,
                fontFamily: 'Monda',
                fontSize: 30,
              ),
              minFontSize: 18,
              maxLines: 1,
              //overflow: TextOverflow.ellipsis,
            ),
            AutoSizeText(
              (widget.tilesCompleted).toString() + ' ',
              style: TextStyle(
                color: constants.kSecondaryColor,
                fontFamily: 'Monda',
                fontSize: 30,
              ),
              minFontSize: 18,
              maxLines: 2,
              //overflow: TextOverflow.ellipsis,
            ),
            AutoSizeText(
              'tiles',
              style: TextStyle(
                color: constants.kSecondaryColorVariant,
                fontFamily: 'Monda',
                fontSize: 30,
              ),
              minFontSize: 18,
              maxLines: 2,
              //overflow: TextOverflow.ellipsis,
            )
          ],
        )
      ],
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

bool kGameFinished = false;
bool kGameInProgress = false;
int kPuzzleShuffleCount = 100;

double kTileSpacing = 0.3;
double kTileWidth = 120;
double kTileHeight = 120;
const double kSmallTileWidth = 80;
const double kSmallTileHeight = 80;

double kInnerTilePadding = 0;
const double kTileBadgeSize = 30;

const double kAppbarHeight = 100;
const double kAppbarLogoTypographySpacing = 200;
const double kAppbarElevation = 10;

final Color kSurfaceColor = Color(0xffDFDFDF);
final Color kOnSurfaceColor = Color(0xff686868);

final Color kOnBackgroundColor = Color(0xffB4B4B4);
final Color kBackgroundColor = Color(0xffFFFFFF);

final Color kOnPrimaryColor = Color(0xff111111);
final Color kPrimaryColorVariant = Color(0xff1E4348);
const Color kPrimaryColor = Color(0xff98CCD3);

final Color kSecondaryColor = Color(0xff20A9FE);
final Color kSecondaryColorVariant = Color(0xff015B93);
final Color kOnSecondaryColor = Color(0xffFFFFFF);

final Color kAccentColor = Color(0xffFFB813);
final Color kOnAccentColor = Color(0xff031927);

final RichText kLogoTypography = RichText(
  text: TextSpan(
    style: TextStyle(
        color: kPrimaryColorVariant,
        fontFamily: 'Montserrat',
        fontSize: 80,
        fontWeight: FontWeight.w200,
        letterSpacing: 0.5),
    children: [
      const TextSpan(
        text: 'Circuit',
      ),
      TextSpan(
        text: 'Slide',
        style: TextStyle(
          color: kPrimaryColor,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w100,
        ),
      ),
    ],
  ),
);

final Widget kLogo = Icon(
  Icons.add_box,
  color: kPrimaryColor,
  size: 110,
);

final TextStyle kLevelStyle = TextStyle(
  fontFamily: 'Monda',
  fontSize: 25,
  color: kOnSurfaceColor,
);
final TextStyle kTileNumberStyle = TextStyle(
  fontSize: 28,
  fontFamily: 'Monda',
  color: kSecondaryColor,
);

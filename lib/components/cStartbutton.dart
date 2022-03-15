import 'package:flutter/material.dart';
import 'dart:async';

import 'package:circuit_slide/constants/constants.dart' as constants;
import 'package:circuit_slide/events.dart';

class StartButton extends StatefulWidget {
  const StartButton({
    Key? key,
  }) : super(key: key);

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  StreamSubscription? subscriptionGameStartEvent;

  @override
  void initState() {
    registerEvents();
    super.initState();
  }

  registerEvents() {
    subscriptionGameStartEvent = eventBus.on<GameStartEvent>().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() async {
    subscriptionGameStartEvent!.cancel();
    subscriptionGameStartEvent = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        eventBus.fire(GameStartEvent());
      },
      color: constants.kSecondaryColor,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Text(
        !constants.kGameInProgress ? 'Start' : 'Restart',
        style: TextStyle(
          color: constants.kOnSecondaryColor,
          fontFamily: 'Monda',
          fontSize: 20,
        ),
      ),
    );
  }
}

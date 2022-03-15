import 'package:flutter/material.dart';
import 'dart:async';

import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:circuit_slide/constants/constants.dart' as constants;
import 'package:circuit_slide/events.dart';

class GameTimer extends StatefulWidget {
  const GameTimer({
    Key? key,
  }) : super(key: key);

  @override
  State<GameTimer> createState() => _GameTimerState();
}

class _GameTimerState extends State<GameTimer> {
  final _isHours = true;
  StreamSubscription? subscriptionGameStartEvent,
      subscriptionGameCompletedEvent;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    // onChange: (value) => print('onChange $value'),
    // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  @override
  void initState() {
    super.initState();
    //_stopWatchTimer.rawTime.listen((value) =>
    //   print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    // _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    // _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    // _stopWatchTimer.records.listen((value) => print('records $value'));

    registerEvents();
  }

  registerEvents() {
    subscriptionGameStartEvent = eventBus.on<GameStartEvent>().listen((event) {
      _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    });

    subscriptionGameCompletedEvent =
        eventBus.on<GameCompletedEvent>().listen((event) {
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    });
  }

  @override
  void dispose() async {
    subscriptionGameStartEvent!.cancel();
    subscriptionGameStartEvent = null;
    subscriptionGameCompletedEvent!.cancel();
    subscriptionGameCompletedEvent = null;
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: _stopWatchTimer.rawTime.value,
          builder: (context, snap) {
            final value = snap.data!;
            final displayTime =
                StopWatchTimer.getDisplayTime(value, hours: _isHours);
            return Text(
              "Timer " + displayTime,
              style: constants.kLevelStyle,
            );
          }),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class QuestionTimer extends StatefulWidget {
  
  final int mSeconds;
  final Function mOnFinishedTimer;

  QuestionTimer({
    @required this.mSeconds, 
    this.mOnFinishedTimer
  });

  @override
  _QuestionTimerState createState() => _QuestionTimerState();
}

class _QuestionTimerState extends State<QuestionTimer> {
  
  Timer _timer;
  int _counterIndex;
  String counterLabel;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _counterIndex = widget.mSeconds;
    counterLabel = _counterIndex.toString();

    startTimer();
  }  
  
  void startTimer() {
    // final questionsModel = Provider.of<QuestionsModel>(context, listen: false);
    const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(
          () {
            if (_counterIndex == 0) {
              counterLabel = "TERMINADO!";
              timer.cancel();
              widget.mOnFinishedTimer();
            } else {
              _counterIndex = _counterIndex - 1;
              counterLabel = _counterIndex.toString();
            }
          },
        ),
    );
  }

  final double _timerFontSize = 24;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FaIcon(FontAwesomeIcons.hourglassHalf, color: lightGreyColor),
        SizedBox(width: 10),
        Text(
          counterLabel,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _timerFontSize,
            color: lightGreyColor
          ),
        )
      ],
    );
  }
}
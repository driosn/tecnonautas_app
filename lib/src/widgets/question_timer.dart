import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tecnonautas_app/core/bloc/question/question_timer_bloc.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class QuestionTimer extends StatefulWidget {
  
  final int mSeconds;
  final Function mOnFinishedTimer;
  final QuestionTimerBloc mQuestionTimerBloc;

  QuestionTimer({
    @required this.mSeconds, 
    this.mOnFinishedTimer,
    @required this.mQuestionTimerBloc
  });

  @override
  _QuestionTimerState createState() => _QuestionTimerState();
}

class _QuestionTimerState extends State<QuestionTimer> {
  
  Timer _timer;
  int _counterIndex;
  String counterLabel;

  Timer _pointTimer;
  int _counterPointsIndex;
  String counterPointsLabel;

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _counterIndex = widget.mSeconds;
    _counterPointsIndex = 0;
    counterLabel = _counterIndex.toString();

    startTimer();
    startPointTimer();
  }  
  
  void startTimer() {
    // final questionsModel = Provider.of<QuestionsModel>(context, listen: false);
    const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(
          () {
            if (_counterIndex == 0 || widget.mQuestionTimerBloc.isCompleted == true) {
              counterLabel = "TERMINADO!";
              timer.cancel();
              _timer.cancel();
              _pointTimer.cancel();
              widget.mOnFinishedTimer();
            } else {
              _counterIndex = _counterIndex - 1;
              counterLabel = _counterIndex.toString();
            }
          },
        ),
    );
  }

  void startPointTimer() {
    const oneMillisec = const Duration(milliseconds: 1);
    _pointTimer = new Timer.periodic(
      oneMillisec,
      (Timer timer) => setState(
        () {
          if (_counterIndex == 0 || widget.mQuestionTimerBloc.isCompleted == true) {
            _counterPointsIndex = _counterPointsIndex + 1;
            print(_counterPointsIndex);
          }
        }
      )
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
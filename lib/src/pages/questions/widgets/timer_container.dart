import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/question/question_timer_bloc.dart';
import 'package:tecnonautas_app/src/widgets/counter_bar.dart';
import 'package:tecnonautas_app/src/widgets/question_timer.dart';

class TimerContainer extends StatelessWidget {
  
  final int mSecondsDuration;
  final QuestionTimerBloc mTimerBloc;

  TimerContainer({
    @required this.mSecondsDuration,
    @required this.mTimerBloc
  });

  final double _timerPadding = 20;
  final double _containerRadius = 10;

  @override
  Widget build(BuildContext context) {
    
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_timerPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_containerRadius) 
      ),
      child: Column(
        children: <Widget>[
          QuestionTimer(
            mSeconds: mSecondsDuration,
            mOnFinishedTimer: _finishTimer,
          ),
          SizedBox(height: 10),
          CounterBar(
            duration: Duration(seconds: mSecondsDuration), 
            barWidth: size.width
          )
        ],
      ),
    );
  }

  void _finishTimer() {
    mTimerBloc.changeIsCompleted(true);
  }
}
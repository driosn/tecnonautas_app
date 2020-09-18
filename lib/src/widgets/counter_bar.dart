import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/question/question_timer_bloc.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class CounterBar extends StatefulWidget {
  
  final Duration duration;
  final double barWidth;
  final QuestionTimerBloc mQuestionTimerBloc;

  CounterBar({@required this.duration, @required this.barWidth, @required this.mQuestionTimerBloc});

  @override
  _CounterBarState createState() => _CounterBarState();
}

class _CounterBarState extends State<CounterBar> with SingleTickerProviderStateMixin{
    
  AnimationController _controller;  
  Animation<double> _animation;
  
  final double _barHeight = 30;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(vsync: this, duration: widget.duration);
    _animation = new Tween(begin: 1.0, end: 0.0).animate(_controller);

    _controller.addListener(() {
      if(_controller.status == AnimationStatus.completed) {
        // Pasamos a la siguiente pagina
      }      
    });

  }

  @override
  Widget build(BuildContext context) {

    final double barRadius = 20;

    _controller.forward();

    return ClipRRect(
      borderRadius: BorderRadius.circular(barRadius),
      child: Stack(
        children: <Widget>[
          Container(
            width: widget.barWidth,
            height: _barHeight,
            decoration: BoxDecoration(
              color: Colors.grey,
            ),    
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget child) {
              
              return  ClipRRect(
                child: Container(
                  width: widget.mQuestionTimerBloc.isCompleted == true ? 0 : widget.barWidth * _animation.value,
                  height: _barHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color> [
                        accent,
                        primary
                      ]
                    ),
                  ),
                ),
              );

            }, 
          )
        ],
      ),
    );
  }


}
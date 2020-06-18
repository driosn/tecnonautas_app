import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  
  final String mQuestionLbl;

  QuestionCard({@required this.mQuestionLbl});

  final double _topPadding = 40;
  final double _bottomPadding = 24;
  final double _horizontalPadding = 30;
  
  final double _cardRadius = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: _topPadding,
        left: _horizontalPadding,
        right: _horizontalPadding,
        bottom: _bottomPadding
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_cardRadius),
        color: Colors.white
      ),
      child: Center(
        child: Text(
          mQuestionLbl, 
          style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
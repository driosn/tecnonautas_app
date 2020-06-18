import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

enum StatusButtonType {
  INCORRECT, CORRECT, READY, WAITING
}

class QuestionStatusButton extends StatelessWidget {
  
  String mStatusLabel;
  Color mTextColor;
  FontWeight mFontWeight;
  Border mBorder;
  StatusButtonType mButtonType;
  double mPointsNumber;
  int mQuestionNumber;
  Function mOnPressed;

  QuestionStatusButton.incorrect({
    @required this.mPointsNumber, 
    @required this.mQuestionNumber,
    @required this.mOnPressed
  }) {
    mStatusLabel = 'INCORRECTO!';
    mTextColor = wrongColor;
    mFontWeight = FontWeight.bold;
    mBorder = Border.all(color: wrongColor, width: 3);
    mButtonType = StatusButtonType.INCORRECT;
  }
  
  QuestionStatusButton.correct({
    @required this.mPointsNumber, 
    @required this.mQuestionNumber,
    @required this.mOnPressed
  }) {
    mStatusLabel = 'CORRECTO!';
    mTextColor = correctColor;
    mFontWeight = FontWeight.bold;
    mBorder = Border.all(color: correctColor, width: 3);
    mButtonType = StatusButtonType.CORRECT;
  }

  QuestionStatusButton.ready({
    @required this.mPointsNumber, 
    @required this.mQuestionNumber,
    @required this.mOnPressed
  }) {
    mStatusLabel = 'Click para empezar!';
    mTextColor = darkGreyColor;
    mFontWeight = FontWeight.w500;
    mButtonType = StatusButtonType.READY;
  }

  QuestionStatusButton.waiting({
    @required this.mPointsNumber, 
    @required this.mQuestionNumber,
    @required this.mOnPressed
  }) {
    mStatusLabel = 'Ya viene!...';
    mTextColor = darkGreyColor.withOpacity(0.5);
    mFontWeight = FontWeight.normal;
    mButtonType = StatusButtonType.WAITING;
  }
  
  final double _buttonHeight = 60;
  final double _fontSize = 16;
  final double _borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Container(
            height: _buttonHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              border: mBorder,
              color: Colors.white,
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: lightGreyColor.withOpacity(0.2), 
                  offset: Offset(0, 3), 
                  blurRadius: 6,
                  spreadRadius: 2
                )
              ]
            ),
            child: Center(
              child: Text(
                mStatusLabel, 
                style: TextStyle(
                  color: mTextColor,
                  fontWeight: mFontWeight,
                  fontSize: _fontSize
                ),
              ),
            )
          ),
          Positioned(
            top: 10,
            left: 10,
            child: _questionNumber(context)
          ),
          Positioned(child: _pointsCard(), right: 0)
        ],
      ),
    );
  }

  Widget _questionNumber(BuildContext context) {
    return Text(
      "Pregunta " + mQuestionNumber.toString(),
      style: TextStyle(
        color: accentLight,
        fontWeight: FontWeight.bold
      )
    );
  }

  Widget _pointsCard() {
    final double _cardWidth = 70;
    final double _cardHeight = 60;
    final double _radius = 10;
    final double _fontSize = 12;

    final Color _pointTextColor = (mButtonType == StatusButtonType.INCORRECT || 
                                  mButtonType == StatusButtonType.CORRECT)
                                  ? Colors.white
                                  : lightGreyColor;

    final FontWeight _pointFontWeight = (mButtonType == StatusButtonType.INCORRECT || 
                                        mButtonType == StatusButtonType.CORRECT)
                                        ? FontWeight.bold
                                        : FontWeight.normal;

    final Text pointText = Text(
      mPointsNumber.toString() + " puntos",
      style: TextStyle(
        color: _pointTextColor,
        fontWeight: _pointFontWeight,
        fontSize: _fontSize
      ),
    );

    return Container(
      height: _cardHeight,
      width: _cardWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(_radius),
          bottomRight: Radius.circular(_radius) 
        ),
        color: mButtonType == StatusButtonType.INCORRECT || mButtonType == StatusButtonType.CORRECT
              ? mTextColor
              : Colors.white
      ),
      child: Center(
        child: pointText,
      ),
    );
  }
}
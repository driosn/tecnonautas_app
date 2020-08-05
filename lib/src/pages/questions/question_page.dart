import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/question/question_timer_bloc.dart';
import 'package:tecnonautas_app/src/pages/questions/widgets/question_card.dart';
import 'package:tecnonautas_app/src/pages/questions/widgets/timer_container.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/trivia_status_page.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/appbar/tecnonautas_appbar.dart';
import 'package:tecnonautas_app/src/widgets/counter_bar.dart';
import 'package:tecnonautas_app/src/widgets/puzzle_piece_button.dart';
import 'package:tecnonautas_app/src/widgets/question_timer.dart';
import 'package:tecnonautas_app/src/widgets/result_card.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_button.dart';

class QuestionPage extends StatelessWidget {
  
  QuestionTimerBloc _questionTimerBloc = new QuestionTimerBloc();

  final double pieceHeight = 140;
  final double containerHeight = 290;
  final double containerWidth = 390;
  final double pieceWidth = 175;
  final double _spacingSize = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TecnonautasAppbar(),
              QuestionCard(mQuestionLbl: 'Cuál de los siguientes compuestos se representa con la fórmula: \nCO2',),
              SizedBox(height: _spacingSize),
              TimerContainer(
                mSecondsDuration: 10,
                mTimerBloc: _questionTimerBloc,
              ),
              SizedBox(height: _spacingSize * 2),
              _questionActions(),
              // ResultCard.correct(mResultDescription: 'El Dióxido de carbono se representa con CO2 porque tiene dos átomos de Oxígeno y uno de Carbono.'),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionActions() {
    return StreamBuilder(
      stream: _questionTimerBloc.isCompletedStream,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.data == false) {
          return _pieceButtons();
        } else {
          return _questionResult(context);
        }

      },
    );
  }

  Widget _questionResult(BuildContext context) {
    final String okLbl = 'OK';
    final double _buttonHeight = 50;
    final double _buttonWidth = 200;
    final double _spacing = 20;

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ResultCard.correct(mResultDescription: 'El Dióxido de carbono se representa con CO2 porque tiene dos átomos de Oxígeno y uno de Carbono.'),
          SizedBox(height: _spacing),
          TecnonautasButton(
            mHeight: _buttonHeight,
            mWidth: _buttonWidth,
            mText: Text(
              okLbl, 
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: lightGreyColor)
            ), 
            mColor: Colors.white, 
            mOnPressed: () => _okAction(context)
          )
        ],
      ),
    );
  }

  Widget _pieceButtons() {
    return Container(
      height: containerHeight,
      width: containerWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              PuzzlePieceButton(
                mHeight: pieceHeight,
                mWidth: pieceWidth, 
                mColor: redPiece,
                piecePlace: PiecePlace.TOP_LEFT,
              ),
              Spacer(),
              PuzzlePieceButton(
                mHeight: pieceHeight,
                mWidth: pieceWidth, 
                mColor: bluePiece,
                piecePlace: PiecePlace.TOP_RIGHT,
              ),
            ],
          ),
          Spacer(),
          Row(
            children: <Widget>[
              PuzzlePieceButton(
                mHeight: pieceHeight,
                mWidth: pieceWidth, 
                mColor: greenPiece,
                piecePlace: PiecePlace.BOTTOM_LEFT,
              ),
              Spacer(),
              PuzzlePieceButton(
                mHeight: pieceHeight,
                mWidth: pieceWidth, 
                mColor: orangePiece,
                piecePlace: PiecePlace.BOTTOM_RIGHT,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _okAction(BuildContext context) {
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => TriviaStatusPage()));
  }
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/question/question_timer_bloc.dart';
import 'package:tecnonautas_app/core/bloc/question/selected_question_bloc.dart';
import 'package:tecnonautas_app/core/bloc/select_active_trivia/selected_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/selected_answer/selected_answer_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_summary/user_summary_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_trivia_ranking/user_trivia_ranking_bloc.dart';
import 'package:tecnonautas_app/core/models/question.dart';
import 'package:tecnonautas_app/src/pages/questions/widgets/question_card.dart';
import 'package:tecnonautas_app/src/pages/questions/widgets/timer_container.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/trivia_status_page.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/show_loading.dart';
import 'package:tecnonautas_app/src/widgets/appbar/tecnonautas_appbar.dart';
import 'package:tecnonautas_app/src/widgets/counter_bar.dart';
import 'package:tecnonautas_app/src/widgets/puzzle_piece_button.dart';
import 'package:tecnonautas_app/src/widgets/question_timer.dart';
import 'package:tecnonautas_app/src/widgets/result_card.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_button.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  
  QuestionTimerBloc _questionTimerBloc = new QuestionTimerBloc();
  final double pieceHeight = 140;
  final double containerHeight = 290;
  final double containerWidth = 390;
  final double _spacingSize = 15;

  List<Color> pieceColors = [
    redPiece,
    bluePiece,
    greenPiece,
    orangePiece
  ];

  List<PiecePlace> piecePlaces = [
    PiecePlace.TOP_LEFT,
    PiecePlace.TOP_RIGHT,
    PiecePlace.BOTTOM_LEFT,
    PiecePlace.BOTTOM_RIGHT, 
  ];

  UserTriviaRankingBloc userTriviaRankingBloc = UserTriviaRankingBloc();
  SelectedAnswerBloc selectedAnswerBloc = SelectedAnswerBloc();
  SelectedActiveTriviaBloc selectedActiveTriviaBloc = SelectedActiveTriviaBloc();

  @override
  void initState() {
    super.initState();
    selectedAnswerBloc.changeSelectedAnswer("");
  }

  @override
  Widget build(BuildContext context) {
    print("Question Page");
    print("Question Page");
    print("Question Page");
    print("Question Page");
    print("Question Page");
    return Scaffold(
      body: StreamBuilder<Question>(
        stream: selectedQuestionBloc.selectedQuestionStream,
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            Question currentQuestion = snapshot.data;

            return Container(
              padding: EdgeInsets.all(24),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TecnonautasAppbar(),
                    QuestionCard(mQuestionLbl: currentQuestion.questionLbl),
                    SizedBox(height: _spacingSize),
                    TimerContainer(
                      mSecondsDuration: currentQuestion.questionTime,
                      mTimerBloc: _questionTimerBloc,
                    ),
                    SizedBox(height: _spacingSize * 2),
                    Expanded(
                      child: SingleChildScrollView(
                        child: _questionActions(
                          mQuestion: currentQuestion
                        ),
                      )
                    )// Spacer()
                  ],
                ),
              ),
            );
          }

          return Container();


        },
      ),
    );
  }

  Widget _questionActions({Question mQuestion}) {
    return StreamBuilder(
      stream: _questionTimerBloc.isCompletedStream,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.data == false) {
          return _pieceButtons(context, mQuestion);
        } else {

          if (selectedAnswerBloc.selectedAnswer == "") {
            // selectedAnswerBloc.changeSelectedAnswer("No respondido");
            userSummaryBloc.postNotAnswered(mQuestion.questionLbl);
          } else if (selectedAnswerBloc.selectedAnswer == mQuestion.respCorrect) {
            userSummaryBloc.postCorrectAnswer(mQuestion.questionLbl); 
          } else if (selectedAnswerBloc.selectedAnswer != mQuestion.respCorrect) {
            userSummaryBloc.postWrongAnswer(mQuestion.questionLbl);
          }

          // selectedAnswerBloc.updateSelectedAnswer(mCorrectAnswer: mQuestion.respCorrect);
          
          // userTriviaRankingBloc.updateTriviaResult(
            // mTriviaId: selectedAnswerBloc.parentTrivia.id,
            // mCorrectAnswer: mQuestion.respCorrect,
            // mSelectedAnswer: selectedAnswerBloc.selectedAnswer
          // );

          return _questionResult(context, mQuestion);
        }
      },
    );
  }

  Widget _questionResult(BuildContext context, Question mQuestion) {
    final String okLbl = 'OK';
    final double _buttonHeight = 50;
    final double _buttonWidth = 200;
    final double _spacing = 20;

    SelectedAnswerBloc bloc = SelectedAnswerBloc();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          
          bloc.selectedAnswer == mQuestion.respCorrect
          ? ResultCard.correct(
              mResultDescription: mQuestion.responses[mQuestion.respCorrect]
            )
          : ResultCard.incorrect(
              mResultDescription: mQuestion.responses[mQuestion.respCorrect]
            ),

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

  Widget _pieceButtons(context, Question mQuestion) {
    return SingleChildScrollView(
      child: Container(
        height: containerHeight,
        width: containerWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Wrap(
              children: List.generate(
                mQuestion.qtyResp, (index) => GestureDetector(
                  child: StreamBuilder(
                    initialData: "",
                    stream: selectedAnswerBloc.selectedAnswerStream,
                    builder: (context, snapshot) {
                      final selectedAns = snapshot.data;

                      return PuzzlePieceButton(
                        mDrawBorder: selectedAns == "resp${mQuestion.questionIndex}$index",
                        mHeight: pieceHeight,
                        mWidth: MediaQuery.of(context).size.width * 0.40,
                        mColor: pieceColors.elementAt(index),
                        piecePlace: piecePlaces.elementAt(index),
                        mText: mQuestion.responses["resp${mQuestion.questionIndex}$index"],
                      );
                    },
                  ),
                  onTap: () {
                    SelectedAnswerBloc bloc = SelectedAnswerBloc();
                    bloc.changeSelectedAnswer("resp${mQuestion.questionIndex}$index");
                    _questionTimerBloc.changeIsCompleted(true);
                  },
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  void _okAction(BuildContext context) {
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => TriviaStatusPage(
        mTrivia: selectedQuestionBloc.parentTrivia,
      )));
  }
}
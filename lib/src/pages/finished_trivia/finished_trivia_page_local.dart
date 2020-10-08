import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/active_trivia/active_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/select_active_trivia/selected_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/selected_answer/selected_answer_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_ranking/user_ranking_bloc.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/core/models/user_answer.dart';
import 'package:tecnonautas_app/core/models/user_trivia_answers.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/widgets/avatar_trivia_info.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/widgets/avatar_trivia_info_local.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/widgets/leave_trivia_dialog.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/widgets/response_average_bar.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/appbar/tecnonautas_appbar.dart';
import 'package:tecnonautas_app/src/widgets/card_container.dart';
import 'package:tecnonautas_app/src/widgets/favorite_button.dart';
import 'package:tecnonautas_app/src/widgets/gradient_button.dart';
import 'package:tecnonautas_app/src/widgets/rounded_button.dart';
import 'package:tecnonautas_app/src/widgets/trivias_status_card.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/widgets/question_status_button.dart';

class FinishedTriviaPageLocal extends StatefulWidget {
  
  Trivia mParentTrivia;

  FinishedTriviaPageLocal({@required this.mParentTrivia});

  @override
  _FinishedTriviaPageState createState() => _FinishedTriviaPageState();
}

class _FinishedTriviaPageState extends State<FinishedTriviaPageLocal> {
  
  final double _pagePadding = 10;
  final double _spacingValue = 10;
  final int _secondsValue = 30;
  final double _buttonRadius = 8;
  final double _buttonWidth = 200;
  final double _appbarPadding = 10;

  SelectedActiveTriviaBloc selectedActiveTriviaBloc = SelectedActiveTriviaBloc();

  @override
  void initState() {
    super.initState();
    selectedAnswerBloc.changeParentTrivia(widget.mParentTrivia);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                CardContainer(
                  mPadding: EdgeInsets.all(_appbarPadding),
                  child: TecnonautasAppbar(),
                ),
                Padding(
                  padding: EdgeInsets.all(_pagePadding),
                  child: Column(
                    children: <Widget>[
                      _TitleCard(title: selectedAnswerBloc.parentTrivia.name),
                      SizedBox(height: _spacingValue),
                      AvatarTriviaInfoLocal(
                        mTriviaId: selectedAnswerBloc.parentTrivia.id,
                        mTriviaQuestionsLen: selectedAnswerBloc.parentTrivia.questions.length,
                        mQuestionsName: selectedAnswerBloc.parentTrivia.questions,
                        avatarRanking: 3,
                        finalScore: 6,
                        totalPlayers: 232,
                      ),
                      SizedBox(height: _spacingValue),
                      // _AverageResponseInfo(mSecondValue: _secondsValue),
                      // SizedBox(height: _spacingValue),
                      _QuestionsStatus(
                        mParentTrivia: selectedAnswerBloc.parentTrivia,
                      ),
                      SizedBox(height: _spacingValue),
                      // _QuestionStatusList(),
                      _questionsStatusList(),
                      // SizedBox(height: _spacingValue * 2),
                      // GradientButton(
                        // mWidth: _buttonWidth,
                        // mRadius: _buttonRadius,
                        // mText: _buttonContent(context), 
                        // mColors: <Color> [
                          // accent,
                          // primary
                        // ], 
                        // mOnPressed: () => _newTrivia(context)
                      // )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }

  Widget _questionsStatusList() {

    UserPreferences prefs = UserPreferences();

    return SingleChildScrollView(
      child: Column(
        children: List.generate(widget.mParentTrivia.questions.length, (index) {
        
            final respuesta = prefs.getQuestionResult(widget.mParentTrivia.questions[index]);

            if (respuesta == "Correct") {
              return QuestionStatusButton.correct(
                mPointsNumber: 10, 
                mQuestionNumber: index + 1, 
                mOnPressed: () {}
              );
            }
            
            return QuestionStatusButton.incorrect(
              mPointsNumber: 0, 
              mQuestionNumber: index + 1, 
              mOnPressed: () {}
            );
                                  
          }
        ),
      )
    );
  }

  UserAnswer searchTriviaNameData(UserTriviaAnswers mUserTriviaAnswers) {
    Map<String, dynamic> foundedData = mUserTriviaAnswers.answers.firstWhere(
      (answer) {
        return answer["triviaName"] == selectedActiveTriviaBloc.selectedActiveTrivia.name;
    });
    return UserAnswer.fromMap(foundedData);
  }

  Widget _buttonContent(BuildContext context) {
    final double _contentPadding = 10;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _contentPadding,
        horizontal: _contentPadding * 2
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.edit, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'NUEVA TRIVIA',
            style: Theme.of(context).textTheme.subhead
          )
        ],
      ),
    );
  }

  void _newTrivia(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/');
  }
}

class _TitleCard extends StatelessWidget {
  
  final String title;

  _TitleCard({@required this.title});

  final double _cardPadding = 10;
  final double _positionSpace = 10;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CardContainer(
          mPadding: EdgeInsets.symmetric(
            horizontal: _cardPadding,
            vertical: _cardPadding* 2
          ),
          child:  Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: accent),
            ),
          ),
        ),

        Positioned(
          left: _positionSpace,
          top: _positionSpace,
          child: _triviaLabel(),
        ),

        Positioned(
          right: _positionSpace,
          top: _positionSpace,
          child: FavoriteButton(
            isFavorite: true, 
            onPressed: _checkFavorite
          ),
        )
      ],
    );
  }

  Widget _triviaLabel() {
    return Text('Trivia', style: TextStyle(color: lightGreyColor),);
  }

  void _checkFavorite() {

  }
}

class _AverageResponseInfo extends StatelessWidget {
  
  int mSecondValue;

  _AverageResponseInfo({@required this.mSecondValue}) {
    if(mSecondValue > 60) mSecondValue = 60;
    if(mSecondValue < 0) mSecondValue = 0;
  }

  final double _barHeight = 25;
  final double _cardPadding = 10;
  final double _verticalSpacing = 5;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      mWidth: double.infinity,
      mPadding: EdgeInsets.all(_cardPadding),
      child: Column(
        children: <Widget>[
          _secondsValue(),
          SizedBox(height: _verticalSpacing),
          ResponseAverageBar(
            barHeight: _barHeight,
            secondValue: mSecondValue,
          ),
          SizedBox(height: _verticalSpacing * 2),
          _averageTimeLabel()
        ],
      ),
    );
  }

  Widget _secondsValue() {
    return Text(
      "$mSecondValue seg",
      style: TextStyle(color: lightGreyColor),
    );
  }

  Widget _averageTimeLabel() {
    return Text(
      'Tiempo de respuesta promedio',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: lightGreyColor
      )
    );
  }
}

class _QuestionsStatus extends StatefulWidget {
  
  Trivia mParentTrivia;

  _QuestionsStatus({
    @required this.mParentTrivia
  });

  @override
  __QuestionsStatusState createState() => __QuestionsStatusState();
}

class __QuestionsStatusState extends State<_QuestionsStatus> {
  final double _cardHeight = 120;

  int mCorrectas = 0;
  int mIncorrectas = 0;
  int mSinRespuesta = 0;

  UserPreferences prefs = UserPreferences();

  @override
  void initState() {
    super.initState();

    for(int i = 0; i < widget.mParentTrivia.questions.length; i++) {
      final statusResponse = prefs.getQuestionResult(widget.mParentTrivia.questions[i]);
      if (statusResponse == "Correct") mCorrectas++;
      else mIncorrectas++;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _cardHeight,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: TriviasStatusCard.correct(
              mLabel: 'Correctas', 
              mTriviasNumber: mCorrectas
            )
          ),
          Expanded(
            child: TriviasStatusCard.wrong(
              mLabel: 'Incorrectas', 
              mTriviasNumber: mIncorrectas
            )
          ),
          Expanded(
            child: TriviasStatusCard.neutral(
              mLabel: 'Sin respuesta', 
              mTriviasNumber: mSinRespuesta
            )
          ),
        ],
      ),
    );
  }
}

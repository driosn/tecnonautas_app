import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/active_trivia/active_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/select_active_trivia/selected_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/selected_answer/selected_answer_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_ranking/user_ranking_bloc.dart';
import 'package:tecnonautas_app/core/models/user_answer.dart';
import 'package:tecnonautas_app/core/models/user_trivia_answers.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/widgets/avatar_trivia_info.dart';
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

class FinishedTriviaPage extends StatelessWidget {
  
  final double _pagePadding = 10;
  final double _spacingValue = 10;

  final int _secondsValue = 30;

  final double _buttonRadius = 8;
  final double _buttonWidth = 200;

  final double _appbarPadding = 10;

  SelectedActiveTriviaBloc selectedActiveTriviaBloc = SelectedActiveTriviaBloc();

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
                      _TitleCard(title: 'Fórmulas Químicas'),
                      SizedBox(height: _spacingValue),
                      AvatarTriviaInfo(
                        mTriviaId: selectedAnswerBloc.parentTrivia.id,
                        avatarRanking: 3,
                        finalScore: 6,
                        totalPlayers: 232,
                      ),
                      // SizedBox(height: _spacingValue),
                      // _AverageResponseInfo(mSecondValue: _secondsValue),
                      SizedBox(height: _spacingValue),
                      _QuestionsStatus(),
                      SizedBox(height: _spacingValue),
                      // _QuestionStatusList(),
                      _questionsStatusList(),
                      SizedBox(height: _spacingValue * 2),
                      GradientButton(
                        mWidth: _buttonWidth,
                        mRadius: _buttonRadius,
                        mText: _buttonContent(context), 
                        mColors: <Color> [
                          accent,
                          primary
                        ], 
                        mOnPressed: () => _newTrivia(context)
                      )
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
    return StreamBuilder(
      stream: activeTriviaBloc.activeTriviaQuestionsStream,
      builder: (context, snapshot) {
      
        if (snapshot.hasData) {
          QuerySnapshot response = snapshot.data;
          DocumentSnapshot document = response.documents.first;

          final data = document.data;
          List<dynamic> questions = data["questions"];
          
          return StreamBuilder<DocumentSnapshot>(
            stream: activeTriviaBloc.userTriviaAnswersStream,
            builder: (context, snapshot) {
            
              if (snapshot.hasData) {
                UserTriviaAnswers userTriviaAnswers = UserTriviaAnswers.fromDocument(snapshot.data.data);                
                UserAnswer userAnswer = searchTriviaNameData(userTriviaAnswers);

                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(questions.length, (index) {
                    
                        Map<String, dynamic> auxMap = Map<String, dynamic>.from(questions[index]);

                        if (auxMap["isActive"] == true) {
                          if (userAnswer.responses[auxMap["name"]] != null || userAnswer.responses[auxMap["name"]].length > 0) {
                            if (userAnswer.responses[auxMap["name"]] == selectedActiveTriviaBloc.selectedActiveTrivia.respCorrect["question$index"]) {
                              return QuestionStatusButton.correct(
                                mPointsNumber: 2.5, 
                                mQuestionNumber: index + 1, 
                                mOnPressed: () {}
                              );
                            }
                            return QuestionStatusButton.incorrect(
                              mPointsNumber: 2.5, 
                              mQuestionNumber: 1, 
                              mOnPressed: () {}
                            );
                          }
                        }

                        if (auxMap["wasPlayed"]) {
                          if (userAnswer.responses[auxMap["name"]] == selectedActiveTriviaBloc.selectedActiveTrivia.respCorrect["question$index"]) {
                            return QuestionStatusButton.correct(
                              mPointsNumber: 2.5, 
                              mQuestionNumber: index + 1, 
                              mOnPressed: () {}
                            );
                          }
                          if (userAnswer.responses[auxMap["name"]] == "" || userAnswer.responses[auxMap["name"]] == "No respondido") {
                            return QuestionStatusButton.notAnswered(
                              mQuestionNumber: index + 1, 
                              mOnPressed: () {}
                            );
                          }
                          return QuestionStatusButton.incorrect(
                            mPointsNumber: 2.5, 
                            mQuestionNumber: index + 1, 
                            mOnPressed: () {}
                          );
                        }
                        return QuestionStatusButton.incorrect(
                          mPointsNumber: 2.5, 
                          mQuestionNumber: index + 1, 
                          mOnPressed: () {}
                        );                         
                      }
                    ),
                  )
                );
              }
              return Container();
              
            }
          );
        }

        return Container();

      },
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

class _QuestionsStatus extends StatelessWidget {
  
  final double _cardHeight = 120;

  final Stream<DocumentSnapshot> userDocumentStream = Firestore.instance
                      .collection("userTriviaRanking")
                      .document(selectedActiveTriviaBloc.selectedActiveTrivia.id)
                      .snapshots();

  UserPreferences prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _cardHeight,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: userDocumentStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DocumentSnapshot documentSnapshot = snapshot.data;
                  Map<String, dynamic> ownProfileData = Map<String, dynamic>();

                  ownProfileData = documentSnapshot.data["ranking"].firstWhere((element) => element["userId"] == prefs.id);

                  return TriviasStatusCard.correct(
                    mLabel: 'Correctas', 
                    mTriviasNumber: ownProfileData["correct"]
                  );
                }
                return Container();
              },
            )
          ),
          Expanded(
            child: StreamBuilder(
              stream: userDocumentStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DocumentSnapshot documentSnapshot = snapshot.data;
                  Map<String, dynamic> ownProfileData = Map<String, dynamic>();

                  ownProfileData = documentSnapshot.data["ranking"].firstWhere((element) => element["userId"] == prefs.id);

                  return TriviasStatusCard.wrong(
                    mLabel: 'Incorrectas', 
                    mTriviasNumber: ownProfileData["wrong"]
                  );
                }
                return Container();
              },
            )
          ),
          Expanded(
            child: StreamBuilder(
              stream: userDocumentStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DocumentSnapshot documentSnapshot = snapshot.data;
                  Map<String, dynamic> ownProfileData = Map<String, dynamic>();

                  ownProfileData = documentSnapshot.data["ranking"].firstWhere((element) => element["userId"] == prefs.id);

                  return TriviasStatusCard.neutral(
                    mLabel: 'Sin respuesta', 
                    mTriviasNumber: ownProfileData["notAnswered"]
                  );
                }
                return Container();
              },
            )
          )
        ],
      ),
    );
  }
}

class _QuestionStatusList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _questionsStatusList();
  }

  Widget _questionsStatusList() {
    return Container(
      child: Column(
        children: <Widget>[
          QuestionStatusButton.correct(
            mPointsNumber: 0, 
            mQuestionNumber: 1,
            mOnPressed:_questionButtonAction,
          ),
          SizedBox(height: 10),
          QuestionStatusButton.incorrect(
            mPointsNumber: 2.5, 
            mQuestionNumber: 2,
            mOnPressed: _questionButtonAction,
          ),
          SizedBox(height: 10),
          QuestionStatusButton.ready(
            mPointsNumber: 2.5, 
            mQuestionNumber: 3,
          mOnPressed: _questionButtonAction,
          ),
          SizedBox(height: 10),
          QuestionStatusButton.waiting(
            mPointsNumber: 2.5, 
            mQuestionNumber: 4,
            mOnPressed: _questionButtonAction,
          ),
        ],
      ),
    );
  }

  void _questionButtonAction() {

  }

}


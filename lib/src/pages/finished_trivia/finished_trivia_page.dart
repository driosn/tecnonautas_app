import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/select_active_trivia/selected_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/selected_answer/selected_answer_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_summary/user_summary_bloc.dart';
import 'package:tecnonautas_app/core/bloc/web_data/web_data_bloc.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/core/models/user_answer.dart';
import 'package:tecnonautas_app/core/models/user_summary.dart';
import 'package:tecnonautas_app/core/models/user_trivia_answers.dart';
import 'package:tecnonautas_app/core/models/web_data.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/widgets/avatar_trivia_info.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/widgets/response_average_bar.dart';
import 'package:tecnonautas_app/src/pages/portal_home/portal_home_page.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/appbar/tecnonautas_appbar.dart';
import 'package:tecnonautas_app/src/widgets/card_container.dart';
import 'package:tecnonautas_app/src/widgets/favorite_button.dart';
import 'package:tecnonautas_app/src/widgets/gradient_button.dart';
import 'package:tecnonautas_app/src/widgets/trivias_status_card.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/widgets/question_status_button.dart';

class FinishedTriviaPage extends StatefulWidget {
  
  Trivia mParentTrivia;

  FinishedTriviaPage({@required this.mParentTrivia});

  @override
  _FinishedTriviaPageState createState() => _FinishedTriviaPageState();
}

class _FinishedTriviaPageState extends State<FinishedTriviaPage> {
  
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
                      _TitleCard(
                        title: selectedAnswerBloc.parentTrivia.name,
                        // isFavorite: selectedAnswerBloc.parentTrivia.fav,
                        isFavorite: false,
                      ),
                      SizedBox(height: _spacingValue),
                      StreamBuilder(
                        stream: userSummaryBloc.userSummaryStream,
                        builder: (context, summarySnapshot) {
                          if (summarySnapshot.hasData) {
                            int correctCounter = 0;
                            UserSummary auxSummary = UserSummary.fromDocumentList(summarySnapshot.data.documents);
                            UserSummary ownUserSummary = auxSummary.getOwnUserSummary();

                            correctCounter = _getContainNumber(selectedAnswerBloc.parentTrivia.questions, ownUserSummary.correctAnswers);

                            return AvatarTriviaInfo(
                              mTriviaId: selectedAnswerBloc.parentTrivia.id,
                              avatarRanking: 1,
                              finalScore: correctCounter * (selectedAnswerBloc.parentTrivia.points / (selectedAnswerBloc.parentTrivia.questions.length)),
                              totalPlayers: 1,
                            );
                          }
                          return Container();
                        },
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
    
  int _getContainNumber(List<String> question, List<String> mIterable) {
    int counter = 0;
    mIterable.forEach((item) {
      if (question.contains(item)) {
        counter += 1;
      }
    });
    return counter;
  }

Widget _questionsStatusList() {
    UserPreferences prefs = UserPreferences();
    print(prefs.id);

    List<String> triviaQuestions = widget.mParentTrivia.questions;

    return StreamBuilder(
      stream: webDataBloc.webDataStream,
      builder: (context, webSnapshot) {
        if (webSnapshot.hasData) {
          WebData webData = WebData.fromDocument(webSnapshot.data.documents.first);

          return StreamBuilder(
            stream: userSummaryBloc.userSummaryStream,
            builder: (context, summarySnapshot) {
              if (summarySnapshot.hasData) {
                UserSummary auxSummary = UserSummary.fromDocumentList(summarySnapshot.data.documents);
                UserSummary ownUserSummary = auxSummary.getOwnUserSummary();

                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      triviaQuestions.length, 
                      (index) {
                        final String question = triviaQuestions[index];

                        if (ownUserSummary.notAnsweredQuestions.contains(question)) {
                          return QuestionStatusButton.notAnswered(
                            mQuestionNumber: index + 1, 
                            mOnPressed: () {}
                          );
                        }              

                        if (ownUserSummary.correctAnswers.contains(question)) {
                          return QuestionStatusButton.correct(
                            mPointsNumber:  double.parse((widget.mParentTrivia.points / widget.mParentTrivia.questions.length).toStringAsFixed(1)), 
                            mQuestionNumber: index + 1, 
                            mOnPressed: () {}
                          );
                        }

                        if (ownUserSummary.wrongQuestions.contains(question)) {
                          return QuestionStatusButton.incorrect(
                            mPointsNumber: 0, 
                            mQuestionNumber: index + 1, 
                            mOnPressed: () {}
                          );
                        }

                        return QuestionStatusButton.waiting(
                          mPointsNumber: double.parse((widget.mParentTrivia.points / widget.mParentTrivia.questions.length).toStringAsFixed(1)), 
                          mQuestionNumber: index + 1, 
                          mOnPressed: () {}
                        );
                      }
                    )
                  )
                );
              }
              return Container();
            },
          );
          // return StreamBuilder(
            // stream: ,
          // );
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
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => PortalHomePage()), (route) => false);
  }
}

class _TitleCard extends StatelessWidget {
  
  final String title;
  final bool isFavorite;

  _TitleCard({
    @required this.title,
    @required this.isFavorite
  });

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
            isFavorite: this.isFavorite, 
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
  
  @override
  __QuestionsStatusState createState() => __QuestionsStatusState();
}

class __QuestionsStatusState extends State<_QuestionsStatus> {

  final double _cardHeight = 120;
  UserPreferences prefs = UserPreferences();
  List<String> questions = selectedActiveTriviaBloc.selectedActiveTrivia.questions;

  int correctCounter = 0;
  int wrongCounter = 0;
  int notAnsweredCounter = 0;

  @override
  void initState() { 
    super.initState();
  }

  int _getContainNumber(List<String> mIterable) {
    int counter = 0;
    mIterable.forEach((item) {
      if (questions.contains(item)) counter += 1;
    });
    return counter;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userSummaryBloc.userSummaryStream,
      builder: (context, summarySnapshot) {
        if (summarySnapshot.hasData) {
          UserSummary auxSummary = UserSummary.fromDocumentList(summarySnapshot.data.documents);
          UserSummary ownUserSummary = auxSummary.getOwnUserSummary();

          correctCounter = _getContainNumber(ownUserSummary.correctAnswers);
          wrongCounter = _getContainNumber(ownUserSummary.wrongQuestions);
          notAnsweredCounter = _getContainNumber(ownUserSummary.notAnsweredQuestions);

          return Container(
            height: _cardHeight,
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: TriviasStatusCard.correct(
                          mLabel: 'Correctas', 
                          mTriviasNumber: correctCounter
                        )
                ),
                Expanded(
                  child: TriviasStatusCard.wrong(
                    mLabel: 'Incorrectas', 
                    mTriviasNumber: wrongCounter
                  )
                ),
                Expanded(
                  child: TriviasStatusCard.neutral(
                    mLabel: 'Sin respuesta', 
                    mTriviasNumber: notAnsweredCounter
                  )
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

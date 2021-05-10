import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/active_trivia/active_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/question/selected_question_bloc.dart';
import 'package:tecnonautas_app/core/bloc/select_active_trivia/selected_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/selected_answer/selected_answer_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_summary/user_summary_bloc.dart';
import 'package:tecnonautas_app/core/bloc/web_data/web_data_bloc.dart';
import 'package:tecnonautas_app/core/models/question.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/core/models/user_answer.dart';
import 'package:tecnonautas_app/core/models/user_summary.dart';
import 'package:tecnonautas_app/core/models/user_trivia_answers.dart';
import 'package:tecnonautas_app/core/models/web_data.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/finished_trivia_page.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/widgets/leave_trivia_dialog.dart';
import 'package:tecnonautas_app/src/pages/play/play_page.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/widgets/question_status_button.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/widgets/trivia_status_description.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/appbar/tecnonautas_appbar.dart';
import 'package:tecnonautas_app/src/widgets/card_container.dart';
import 'package:tecnonautas_app/src/widgets/info_card.dart';
import 'package:tecnonautas_app/src/widgets/rounded_button.dart';

class TriviaStatusPage extends StatelessWidget {
  
  final Trivia mTrivia;

  TriviaStatusPage({@required this.mTrivia});

  final double _horizontalPadding = 10;
  final double _verticalPadding = 15;
  final double _cardHeight = 160;
  final double _verticalSpacing = 10;
  final double _horizontalSpacing = 12;

  @override
  Widget build(BuildContext context) {
    final triviaStatusPage = Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (context) => LeaveTriviaDialog()
          );
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _horizontalPadding, 
              vertical: _verticalPadding
            ),
            child: Column(
              children: <Widget>[
                _CustomAppbar(),
                SizedBox(height: _verticalSpacing),
                TriviaStatusDescription(
                  mTitle: mTrivia.name,
                  mDescription: mTrivia.description,
                  mIsFavorite: false,
                ),
                SizedBox(height: _verticalSpacing),
                _triviaInformation(context),
                SizedBox(height: _verticalSpacing),
                _questionsStatusList()
              ],
            ),
          ),
        ),
      ),
    );
    
    return StreamBuilder(
      stream: userSummaryBloc.userSummaryStream,
      builder: (context, summarySnapshot) {
        if (summarySnapshot.hasData) {
          UserSummary auxSummary = UserSummary.fromDocumentList(summarySnapshot.data.documents);
          UserSummary ownUserSummary = auxSummary.getOwnUserSummary();
          List<String> questions = mTrivia.questions;

          int playedQuestionsCounter = 0;
          
          questions.forEach((question) {
            if (ownUserSummary.correctAnswers.contains(question) 
              || ownUserSummary.wrongQuestions.contains(question)
              || ownUserSummary.notAnsweredQuestions.contains(question)) {
                playedQuestionsCounter += 1;
              }
          });

          bool isCompletedTrivia = playedQuestionsCounter == questions.length;

          if (isCompletedTrivia) {
            return FinishedTriviaPage(mParentTrivia: mTrivia);
          }
          return triviaStatusPage;
          

          // QuerySnapshot response = snapshot.data;
          // DocumentSnapshot document = response.documents.first;
// 
          // final data = document.data;
          // List<dynamic> questions = data["questions"];
// 
          // bool completedTrivia = true;
          // for(int i = 0; i < questions.length - 1; i++) {
            // if(questions[i]["wasPlayed"] == false) completedTrivia = false;
          // } 
// 
          // if (completedTrivia) {
            // return StreamBuilder<DocumentSnapshot>(
              // stream: activeTriviaBloc.userTriviaAnswersStream,
              // builder: (context, snapshot) {
// 
                // if (snapshot.hasData) {
                  // UserTriviaAnswers userTriviaAnswers = UserTriviaAnswers.fromDocument(snapshot.data.data);                
                  // UserAnswer userAnswer = searchTriviaNameData(userTriviaAnswers);
// 
                  // if (userAnswer.responses["${questions.last["name"]}"] != null && userAnswer.responses["${questions.last["name"]}"] != "") {
                    // return FinishedTriviaPage(mParentTrivia: mTrivia);
                  // }
                  // return triviaStatusPage;
                // }
                // return Container();     
              // }
            // );
          // }
        }
        return Container();
      },
    );
  }

  Widget _cardContent(BuildContext context, String mNumber, String mMiniDesc, {bool isGold}) {
    
    final double contentPadding = 12;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: contentPadding),
        Text(
          mNumber, 
          style: Theme.of(context).textTheme.headline4.copyWith(
            color: Colors.black54, fontWeight: FontWeight.bold
        )),
        Text(
          mMiniDesc, 
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),
        ) 
      ],
    );
  }

  Widget _triviaInformation(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: InfoCard(
              mHeight: _cardHeight, 
              mTitle: 'Responde', 
              mIcon: Icon(Icons.ac_unit, color: accent), 
              mChild: _cardContent(context, mTrivia.questions.length.toString(), 'Preguntas \n(lo antes posible)', isGold: false)
            ),
          ),
          SizedBox(width: _horizontalSpacing),
          Expanded(
            child: InfoCard(
              mHeight: _cardHeight, 
              mTitle: 'Gana', 
              mIcon: Image.asset('assets/images/gold_coin.png'), 
              mChild: _cardContent(context, mTrivia.points.toString(), 'Puntos', isGold: true)
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionsStatusList() {
    UserPreferences prefs = UserPreferences();
    print(prefs.id);

    List<String> triviaQuestions = mTrivia.questions;

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
                            mPointsNumber:  double.parse((mTrivia.points / mTrivia.questions.length).toStringAsFixed(1)), 
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

                        if (webData.activeQuestions.contains(question)) {
                          return QuestionStatusButton.ready(
                            mPointsNumber: double.parse((mTrivia.points / mTrivia.questions.length).toStringAsFixed(1)), 
                            mQuestionNumber: index + 1, 
                            mOnPressed: () {
                            SelectedAnswerBloc bloc = SelectedAnswerBloc()
                              // ..changeUserAnswer(userAnswer)
                              ..changeQuestion(question)
                              ..changeParentTrivia(mTrivia);
//      
                              _selectQuestion(question, index);
                              _goToQuestion(context);
                            }
                          );
                        }

                        return QuestionStatusButton.waiting(
                          mPointsNumber: double.parse((mTrivia.points / mTrivia.questions.length).toStringAsFixed(1)), 
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

    return Container();
    // return StreamBuilder(
    //   stream: activeTriviaBloc.activeTriviaQuestionsStream,
    //   builder: (context, snapshot) {

    //     if (snapshot.hasData) {
    //       QuerySnapshot response = snapshot.data;
    //       DocumentSnapshot document = response.documents.first;

    //       final data = document.data;
    //       List<dynamic> questions = data["questions"];
          
    //       return StreamBuilder<DocumentSnapshot>(
    //         stream: activeTriviaBloc.userTriviaAnswersStream,
    //         builder: (context, snapshot) {

    //           if (snapshot.hasData) {
    //             UserTriviaAnswers userTriviaAnswers = UserTriviaAnswers.fromDocument(snapshot.data.data);                
    //             UserAnswer userAnswer = searchTriviaNameData(userTriviaAnswers);

    //             return SingleChildScrollView(
    //               child: Column(
    //                 children: List.generate(questions.length, (index) {
                    
    //                     Map<String, dynamic> auxMap = Map<String, dynamic>.from(questions[index]);

    //                     if (auxMap["isActive"] == true) {
    //                       if (userAnswer.responses[auxMap["name"]] == null || userAnswer.responses[auxMap["name"]].length > 0) {
    //                         if (userAnswer.responses[auxMap["name"]] == mTrivia.respCorrect["question$index"]) {
    //                           return QuestionStatusButton.correct(
    //                               mPointsNumber:  double.parse((mTrivia.points / mTrivia.questions.length).toStringAsFixed(1)), 
    //                               mQuestionNumber: index + 1, 
    //                               mOnPressed: () {}
    //                             );
    //                           }
    //                           return QuestionStatusButton.incorrect(
    //                             mPointsNumber: 0, 
    //                             mQuestionNumber: index + 1, 
    //                             mOnPressed: () {}
    //                           );
    //                       }
    //                       return QuestionStatusButton.ready(
    //                         mPointsNumber: double.parse((mTrivia.points / mTrivia.questions.length).toStringAsFixed(1)), 
    //                         mQuestionNumber: index + 1, 
    //                         mOnPressed: () {
    //                         SelectedAnswerBloc bloc = SelectedAnswerBloc()
    //                           ..changeUserAnswer(userAnswer)
    //                           ..changeQuestion(auxMap["name"])
    //                           ..changeParentTrivia(mTrivia);

    //                           _selectQuestion(auxMap["name"], index);
    //                           _goToQuestion(context);
    //                         }
    //                       );
    //                     }

    //                     if (auxMap["wasPlayed"]) {
    //                       if (userAnswer.responses[auxMap["name"]] == mTrivia.respCorrect["question$index"]) {
    //                         return QuestionStatusButton.correct(
    //                           mPointsNumber: double.parse((mTrivia.points / mTrivia.questions.length).toStringAsFixed(1)), 
    //                           mQuestionNumber: index + 1, 
    //                           mOnPressed: () {}
    //                         );
    //                       }
    //                       if (userAnswer.responses[auxMap["name"]] == "" || userAnswer.responses[auxMap["name"]] == "No respondido") {
    //                         return QuestionStatusButton.notAnswered(
    //                           mQuestionNumber: index + 1, 
    //                           mOnPressed: () {}
    //                         );
    //                       }
    //                       return QuestionStatusButton.incorrect(
    //                         mPointsNumber: 0, 
    //                         mQuestionNumber: index + 1, 
    //                         mOnPressed: () {}
    //                       );
    //                     } 
                        
    //                     return QuestionStatusButton.waiting(
    //                       mPointsNumber: double.parse((mTrivia.points / mTrivia.questions.length).toStringAsFixed(1)), 
    //                       mQuestionNumber: index + 1, 
    //                       mOnPressed: () {}
    //                     );
    //                   }
    //                 ),
    //               )
    //             );
    //           }
    //           return Container();
              
    //         }
    //       );
    //     }
    //     return Container();
    //   },
    // );
  }

  UserAnswer searchTriviaNameData(UserTriviaAnswers mUserTriviaAnswers) {
    Map<String, dynamic> foundedData = mUserTriviaAnswers.answers.firstWhere(
      (answer) {
        return answer["triviaName"] == selectedActiveTriviaBloc.selectedActiveTrivia.name;
    });
    return UserAnswer.fromMap(foundedData);
  }

  void _selectQuestion(String mQuestionName, int pressedIndex) {
    int questionIndex = -1;

    for(int i = 0; i < mTrivia.questions.length; i++) {
      if (mTrivia.questions[i] == mQuestionName) questionIndex = i;
    }

    Question question  = Question(
      questionIndex: pressedIndex,
      qtyResp: mTrivia.qtyResp["question$questionIndex"],
      questionTime: mTrivia.questionTime["question$questionIndex"],
      questionLbl: mTrivia.questions[questionIndex],
      respCorrect: mTrivia.respCorrect["question$questionIndex"],
      responses: mTrivia.responses["question$questionIndex"]
    );
  
    selectedQuestionBloc.changeParentTrivia(mTrivia);
    selectedQuestionBloc.changeSelectedQuestion(question);  
  }

  void _goToQuestion(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PlayPage()
      )
    );
  }

}

class _CustomAppbar extends StatelessWidget {
  
  final double _buttonRadius = 5;
  final double _buttonHeight = 30;
  final double _buttonWidth = 125;
  final double _appBarPadding = 10;
  final double _fontSize = 11;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      mPadding: EdgeInsets.all(_appBarPadding),
      mWidth: double.infinity,
      child: Column(
        children: <Widget>[
          TecnonautasAppbar(),
          Align(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              mOnPressed: () => _leaveTrivia(context),
              mColor: beigeColor,
              mHeight: _buttonHeight, 
              mWidth: _buttonWidth, 
              mText: Text(
                'Abandonar Trivia', 
                style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w500),
              ), 
              mRadius: _buttonRadius,
            )
          )
        ],
      ),
    );
  }

  void _leaveTrivia(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {

        return LeaveTriviaDialog();

      }
    );
  }
}
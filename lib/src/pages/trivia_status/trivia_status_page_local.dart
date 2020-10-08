import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/active_trivia/active_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/question/selected_question_bloc.dart';
import 'package:tecnonautas_app/core/bloc/select_active_trivia/selected_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/selected_answer/selected_answer_bloc.dart';
import 'package:tecnonautas_app/core/models/question.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/core/models/user_answer.dart';
import 'package:tecnonautas_app/core/models/user_trivia_answers.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/finished_trivia_page.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/finished_trivia_page_local.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/widgets/leave_trivia_dialog.dart';
import 'package:tecnonautas_app/src/pages/play/play_page.dart';
import 'package:tecnonautas_app/src/pages/play_local/play_page_local.dart';
import 'package:tecnonautas_app/src/pages/questions_local/question_local_page.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/widgets/question_status_button.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/widgets/trivia_status_description.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/db_provider.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/appbar/tecnonautas_appbar.dart';
import 'package:tecnonautas_app/src/widgets/card_container.dart';
import 'package:tecnonautas_app/src/widgets/info_card.dart';
import 'package:tecnonautas_app/src/widgets/rounded_button.dart';

class TriviaStatusPageLocal extends StatefulWidget {
  
  final Trivia mTrivia;

  TriviaStatusPageLocal({@required this.mTrivia});

  @override
  _TriviaStatusPageLocalState createState() => _TriviaStatusPageLocalState();
}

class _TriviaStatusPageLocalState extends State<TriviaStatusPageLocal> {

  final double _horizontalPadding = 10;
  final double _verticalPadding = 15;
  final double _cardHeight = 160;
  final double _verticalSpacing = 10;
  final double _horizontalSpacing = 12;

  UserPreferences prefs = UserPreferences();
  bool wasPlayed = true;

  @override
  void initState() {
    super.initState();
    int response = prefs.getAnsweredQuestionsQty(widget.mTrivia);
    // wasPlayed = response == widget.mTrivia.qtyPreg;

    // if (wasPlayed) {
    //   DBProvider.db.setTriviaToPlayed(int.parse(widget.mTrivia.id));  
    // } else {
    //   DBProvider.db.setTriviaToNotPlayed(int.parse(widget.mTrivia.id));
    // }
  }

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
                  mTitle: widget.mTrivia.name,
                  mDescription: widget.mTrivia.description,
                  mIsFavorite: false,
                ),
                SizedBox(height: _verticalSpacing),
                _triviaInformation(context),
                SizedBox(height: _verticalSpacing),
                _questionsStatusList(context)
              ],
            ),
          ),
        ),
      ),
    );
    
    int answeredQuestions = 0;

    for(int i = 0; i < widget.mTrivia.questions.length; i++) {
      String questionResult = prefs.getQuestionStatus(widget.mTrivia.questions[i]);
      if (questionResult == "Correct" || questionResult == "Wrong") {
        answeredQuestions = answeredQuestions + 1;
      }
    }


    return answeredQuestions != widget.mTrivia.questions.length 
            ? triviaStatusPage 
            : FinishedTriviaPageLocal(mParentTrivia: widget.mTrivia);

    // return StreamBuilder(
    //   stream: activeTriviaBloc.activeTriviaQuestionsStream,
    //   builder: (context, snapshot) {

    //     if (snapshot.hasData) {
    //       QuerySnapshot response = snapshot.data;
    //       DocumentSnapshot document = response.documents.first;

    //       final data = document.data;
    //       List<dynamic> questions = data["questions"];

    //       bool completedTrivia = true;
    //       for(int i = 0; i < questions.length - 1; i++) {
    //         if(questions[i]["wasPlayed"] == false) completedTrivia = false;
    //       } 

    //       if (completedTrivia) {
    //         return StreamBuilder<DocumentSnapshot>(
    //           stream: activeTriviaBloc.userTriviaAnswersStream,
    //           builder: (context, snapshot) {

    //             if (snapshot.hasData) {
    //               UserTriviaAnswers userTriviaAnswers = UserTriviaAnswers.fromDocument(snapshot.data.data);                
    //               UserAnswer userAnswer = searchTriviaNameData(userTriviaAnswers);

    //               if (userAnswer.responses["${questions.last["name"]}"] != null && userAnswer.responses["${questions.last["name"]}"] != "") {
    //                 return FinishedTriviaPage(mParentTrivia: mTrivia);
    //               }
    //               return triviaStatusPage;
    //             }
    //             return Container();     
    //           }
    //         );
    //       }
    //       return triviaStatusPage;
    //     }
    //     return Container();
    //   },
    // );
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
              mChild: _cardContent(context, widget.mTrivia.questions.length.toString(), 'Preguntas \n(lo antes posible)', isGold: false)
            ),
          ),
          SizedBox(width: _horizontalSpacing),
          Expanded(
            child: InfoCard(
              mHeight: _cardHeight, 
              mTitle: 'Gana', 
              mIcon: Image.asset('assets/images/gold_coin.png'), 
              mChild: _cardContent(context, widget.mTrivia.points.toString(), 'Puntos', isGold: true)
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionsStatusList(context) {
    UserPreferences prefs = UserPreferences();

    return SingleChildScrollView(
      child: Column(
        children: List.generate(widget.mTrivia.questions.length, (index) {
          
          String questionResult = prefs.getQuestionStatus(widget.mTrivia.questions[index]);
          DBProvider.db.setTriviaToPlayed(int.parse(widget.mTrivia.id));

          if (questionResult == "Correct") {
            return QuestionStatusButton.correct(
              mPointsNumber: double.parse((widget.mTrivia.points / widget.mTrivia.questions.length).toStringAsFixed(1)), 
              mQuestionNumber: index + 1, 
              mOnPressed: () {}
            );
          }

          if (questionResult == "Wrong") {
            return QuestionStatusButton.incorrect(
              mPointsNumber: 0,
              mQuestionNumber: index + 1, 
              mOnPressed: () {}
            );
          }

          wasPlayed = false;
          DBProvider.db.setTriviaToNotPlayed(int.parse(widget.mTrivia.id));
          return QuestionStatusButton.ready(
            mPointsNumber: double.parse((widget.mTrivia.points / widget.mTrivia.questions.length).toStringAsFixed(1)),
            mQuestionNumber: index + 1, 
            mOnPressed: () {
              Question question  = Question(
                questionIndex: index,
                qtyResp: widget.mTrivia.qtyResp["question$index"],
                questionTime: widget.mTrivia.questionTime["question$index"],
                questionLbl: widget.mTrivia.questions[index],
                respCorrect: widget.mTrivia.respCorrect["question$index"],
                responses: widget.mTrivia.responses["question$index"]
              );

              SelectedAnswerBloc bloc = SelectedAnswerBloc()
                  // ..changeUserAnswer(userAnswer)
                  ..changeQuestion(widget.mTrivia.questions[index])
                  ..changeParentTrivia(widget.mTrivia);

              selectedQuestionBloc.changeSelectedQuestion(question);
              selectedQuestionBloc.changeParentTrivia(widget.mTrivia);
              
              _goToQuestionPage(context);
            }
          );

        }),
      ),
    );
  }

  void _goToQuestionPage(context) {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (_) => PlayPageLocal())
    );
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

    for(int i = 0; i < widget.mTrivia.questions.length; i++) {
      if (widget.mTrivia.questions[i] == mQuestionName) questionIndex = i;
    }

    Question question  = Question(
      questionIndex: pressedIndex,
      qtyResp: widget.mTrivia.qtyResp["question$questionIndex"],
      questionTime: widget.mTrivia.questionTime["question$questionIndex"],
      questionLbl: widget.mTrivia.questions[questionIndex],
      respCorrect: widget.mTrivia.respCorrect["question$questionIndex"],
      responses: widget.mTrivia.responses["question$questionIndex"]
    );
  
    selectedQuestionBloc.changeParentTrivia(widget.mTrivia);
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
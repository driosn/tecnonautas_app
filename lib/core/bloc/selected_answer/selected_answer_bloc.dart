import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';
import 'package:tecnonautas_app/core/bloc/user_ranking/user_ranking_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_trivia_ranking/user_trivia_ranking_bloc.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/core/models/user_answer.dart';
import 'package:tecnonautas_app/core/models/user_ranking.dart';
import 'package:tecnonautas_app/core/models/user_trivia_answers.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';

class SelectedAnswerBloc {

  static final SelectedAnswerBloc _singleton = SelectedAnswerBloc._internal();
  
  factory SelectedAnswerBloc() => _singleton;

  SelectedAnswerBloc._internal() {
    changeSelectedAnswer("");
  }

  UserPreferences prefs = UserPreferences();

  // Controllers
  BehaviorSubject<String> _selectedAnswerController = BehaviorSubject<String>();
  BehaviorSubject<UserAnswer> _userAnswerController = BehaviorSubject<UserAnswer>();
  BehaviorSubject<String> _questionController = BehaviorSubject<String>();
  BehaviorSubject<Trivia> _parentTriviaController = BehaviorSubject<Trivia>();

  // Stremas
  Stream<String> get selectedAnswerStream => _selectedAnswerController.stream;
  Stream<UserAnswer> get userAnswerStream => _userAnswerController.stream;
  Stream<String> get questionStream => _questionController.stream;
  Stream<Trivia> get parentTriviaStream => _parentTriviaController.stream;

  // Inputs
  Function(String) get changeSelectedAnswer => _selectedAnswerController.sink.add;
  Function(UserAnswer) get changeUserAnswer => _userAnswerController.sink.add;
  Function(String) get changeQuestion => _questionController.sink.add;
  Function(Trivia) get changeParentTrivia => _parentTriviaController.sink.add;

  // Values
  String get selectedAnswer => _selectedAnswerController.value;
  UserAnswer get userAnswer => _userAnswerController.value;
  String get question => _questionController.value;
  Trivia get parentTrivia => _parentTriviaController.value;

  Future<void> updateSelectedAnswer({String mCorrectAnswer}) async {
    double valuePerQuestion = (this.parentTrivia.points / this.parentTrivia.qtyPreg);   
    valuePerQuestion = double.parse(valuePerQuestion.toStringAsFixed(2));
    
    UserTriviaAnswers response = UserTriviaAnswers.fromDocument((await Firestore.instance.collection("userTriviaAnswers").document(prefs.id).get()).data);

    int currentTriviaIndex = response.answers.indexWhere((answer) => answer["triviaName"] == this.parentTrivia.name);
    Map<String, dynamic> questionMap = response.answers.elementAt(currentTriviaIndex);
    Map<String, String> responses = Map<String, String>.from(questionMap["responses"]);
    Map<String, double> scores = Map<String, double>.from(questionMap["scores"]);
    double totalScore = questionMap["totalScore"];

    responses[this.question] = this.selectedAnswer;

    if (this.selectedAnswer == mCorrectAnswer) {
      // If the answer is correct we update points also in firebase
      UserRankingBloc userRankingBloc = UserRankingBloc();
      UserTriviaRankingBloc userTriviaRankingBloc = UserTriviaRankingBloc();
      await userRankingBloc.addPointsByUserId(valuePerQuestion);
      await userTriviaRankingBloc.addPointsToTriviaRanking(
        mTriviaId: parentTrivia.id,
        mPoints: valuePerQuestion
      );

      scores[this.question] = valuePerQuestion;
      totalScore = totalScore + valuePerQuestion;
    }

    await Firestore.instance.collection("userTriviaAnswers").document(prefs.id).updateData({
      "answers" : rebuildList(
        mUserTriviaAnswers: response,
        mResponses: responses,
        mScores: scores,
        mTotalScore: totalScore,
        mTriviaName: this.parentTrivia.name,
        mIndex: currentTriviaIndex
      )
    });
  }

  List<Map<String, dynamic>> rebuildList({
    UserTriviaAnswers mUserTriviaAnswers, 
    int mIndex,
    Map<String, dynamic> mResponses,
    Map<String, double> mScores,
    double mTotalScore,
    String mTriviaName
  }) {
    List<Map<String, dynamic>> auxiliarList = List<Map<String, dynamic>>();
    for(int i = 0; i < mUserTriviaAnswers.answers.length; i++) {
      if (mIndex == i) {
        auxiliarList.add({
          "responses" : mResponses,
          "scores" : mScores,
          "totalScore" : mTotalScore,
          "triviaName" : mTriviaName
        });
      } else {
        auxiliarList.add(mUserTriviaAnswers.answers[i]);
      }
    }

    return auxiliarList;
  }

  void dispose() {
    _selectedAnswerController?.close();
    _userAnswerController?.close();
    _questionController?.close();
    _parentTriviaController?.close();
  }
}

SelectedAnswerBloc selectedAnswerBloc = SelectedAnswerBloc();
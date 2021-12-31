import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tecnonautas_app/core/bloc/selected_answer/selected_answer_bloc.dart';
import 'package:tecnonautas_app/core/models/user_summary.dart';
import 'package:tecnonautas_app/core/models/web_data.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';

class UserSummaryBloc {

  static final UserSummaryBloc _singleton = UserSummaryBloc._internal();

  factory UserSummaryBloc() => _singleton;

  UserSummaryBloc._internal();

  final UserPreferences prefs = UserPreferences();

  // Firestore Web Data
  Stream<QuerySnapshot> get userSummaryStream => Firestore.instance.collection('userSummary').snapshots();

  Future<UserSummary> fetchUserSummary() async {
    DocumentSnapshot response = await Firestore.instance.collection("userSummary").document(prefs.id).get();
    return UserSummary.fromDocument(response);
  }

  postCorrectAnswer(String mQuestionLbl) async {
    UserSummary summary = await fetchUserSummary();
    if (!summary.correctAnswers.contains(mQuestionLbl)) {
      selectedAnswerBloc.addCorrectScore();
      summary.correctAnswers.add(mQuestionLbl);
      summary.reference.updateData({ "correctAnswers" : summary.correctAnswers });
    }
  }

  postNotAnswered(String mQuestionLbl) async {
    UserSummary summary = await fetchUserSummary();
    if (!summary.notAnsweredQuestions.contains(mQuestionLbl)) {
      summary.notAnsweredQuestions.add(mQuestionLbl);
      summary.reference.updateData({ "notAnsweredQuestions" : summary.notAnsweredQuestions });
    }
  }

  postWrongAnswer(String mQuestionLbl) async {
    UserSummary summary = await fetchUserSummary();
    if (!summary.wrongQuestions.contains(mQuestionLbl)) {
      summary.wrongQuestions.add(mQuestionLbl);
      summary.reference.updateData({ "wrongQuestions" : summary.wrongQuestions});
    }
  }

  createNewuserSummary(String mUserId) async {
    await Firestore.instance.collection('userSummary').document(mUserId).setData({
      "correctAnswers" : [],
      "notAnsweredQuestions" : [],
      "wrongQuestions" : []
    });
  }
}

UserSummaryBloc userSummaryBloc = UserSummaryBloc();
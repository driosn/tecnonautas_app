import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';

class UserSummary {

  String id;
  List<String> correctAnswers;
  List<String> notAnsweredQuestions;
  List<String> wrongQuestions;
  DocumentReference reference;

  UserSummary({
    this.id,
    this.correctAnswers,
    this.notAnsweredQuestions,
    this.wrongQuestions,
    this.reference
  });

  List<UserSummary> summaries;

  UserSummary.fromDocumentList(List<DocumentSnapshot> documents) {
    summaries = new List<UserSummary>();
    if (documents != null) {
      documents.forEach((document) {
        summaries.add(UserSummary.fromDocument(document));
      });
    }
  }

  factory UserSummary.fromDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data;
    print("CORRECT ANSWERS: ${data['correctAnswers']}");

    return UserSummary(
      id: data["id"],
      correctAnswers: List<String>.from(data["correctAnswers"]),
      notAnsweredQuestions: List<String>.from(data["notAnsweredQuestions"]),
      wrongQuestions: List<String>.from(data["wrongQuestions"]),
      reference: snapshot.reference
    );
  }

  UserSummary getOwnUserSummary() {
    UserPreferences prefs = UserPreferences();
    print(summaries);
    return summaries.where((summary) => summary.reference.documentID == prefs.id).first;
  }
}
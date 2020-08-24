import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';

class UserTriviaRankingBloc {

  static final UserTriviaRankingBloc singleton = UserTriviaRankingBloc._();

  factory UserTriviaRankingBloc() => singleton;

  UserTriviaRankingBloc._();

  UserPreferences prefs = UserPreferences();

  // Controller
  

  // Streams
  Stream<QuerySnapshot>  get queryUserTriviaRankingStream => Firestore.instance.collection("userTriviaRanking").snapshots();
  


  Future<void> createNewUserTriviaRanking(String mTriviaId) async {
    DocumentSnapshot response = await Firestore.instance.collection("userTriviaRanking").document(mTriviaId).get();

    List<Map<String, dynamic>> userRankingList = List<Map<String, dynamic>>();

    bool existsUserInTrivia = false;

    response.data["ranking"].forEach((userRanking) {
      if (userRanking["userId"] == prefs.id) existsUserInTrivia = true;
      userRankingList.add(Map<String, dynamic>.from(userRanking));
    });

    if (!existsUserInTrivia) {
      userRankingList.add({
        "userId" : prefs.id,
        "username" : prefs.username,
        "points" : 0.0,
        "correct" : 0,
        "wrong" : 0,
        "notAnswered" : 0
      });
      await response.reference.updateData({
        "ranking" : userRankingList
      });
    }
  }

  Future<void> addPointsToTriviaRanking({String mTriviaId, double mPoints}) async {
    DocumentSnapshot response = await Firestore.instance.collection("userTriviaRanking").document(mTriviaId).get();
    List<Map<String, dynamic>> userRankingList = List<Map<String, dynamic>>();

    response.data["ranking"].forEach((userRanking) {
      if (userRanking["userId"] == prefs.id) {
        double myOwnTriviaPoints = double.parse(userRanking["points"].toString());
        myOwnTriviaPoints = myOwnTriviaPoints + mPoints;
        userRanking["points"] = myOwnTriviaPoints;
      }
      userRankingList.add(Map<String, dynamic>.from(userRanking));
    });

    await response.reference.updateData({
      "ranking" : userRankingList
    });
  }

  void updateTriviaResult({String mTriviaId, String mCorrectAnswer, String mSelectedAnswer}) async {
    if (mCorrectAnswer == mSelectedAnswer) {
      await addCorrectAnswer(mTriviaId);
    } else if (mSelectedAnswer == "" || mSelectedAnswer == "No respondido") {
      await addNotAnswered(mTriviaId);
    } else if (mCorrectAnswer != mSelectedAnswer) {
      await addWrongAnswer(mTriviaId);
    }
  }

  Future<void> addCorrectAnswer(String mTriviaId) async {
    DocumentSnapshot response = await Firestore.instance.collection("userTriviaRanking").document(mTriviaId).get();
    List<Map<String, dynamic>> userRankingList = List<Map<String, dynamic>>();

    response.data["ranking"].forEach((userRanking) {
      if (userRanking["userId"] == prefs.id) {
        userRanking["correct"]++;
      }
      userRankingList.add(Map<String, dynamic>.from(userRanking));
    });

    await response.reference.updateData({
      "ranking" : userRankingList
    });
  }

  Future<void> addWrongAnswer(String mTriviaId) async {
    DocumentSnapshot response = await Firestore.instance.collection("userTriviaRanking").document(mTriviaId).get();
    List<Map<String, dynamic>> userRankingList = List<Map<String, dynamic>>();

    response.data["ranking"].forEach((userRanking) {
      if (userRanking["userId"] == prefs.id) {
        userRanking["wrong"]++;
      }
      userRankingList.add(Map<String, dynamic>.from(userRanking));
    });

    await response.reference.updateData({
      "ranking" : userRankingList
    });
  }

  Future<void> addNotAnswered(String mTriviaId) async {
    DocumentSnapshot response = await Firestore.instance.collection("userTriviaRanking").document(mTriviaId).get();
    List<Map<String, dynamic>> userRankingList = List<Map<String, dynamic>>();

    response.data["ranking"].forEach((userRanking) {
      if (userRanking["userId"] == prefs.id) {
        userRanking["notAnswered"]++;
      }
      userRankingList.add(Map<String, dynamic>.from(userRanking));
    });

    await response.reference.updateData({
        "ranking" : userRankingList
    });
  }
}

UserTriviaRankingBloc userTriviaRankingBloc = UserTriviaRankingBloc();
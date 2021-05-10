import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';
import 'package:tecnonautas_app/core/models/user_ranking.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';

class UserRankingBloc {

  static final UserRankingBloc instance = UserRankingBloc._();

  factory UserRankingBloc() => instance;

  UserRankingBloc._();  

  UserPreferences prefs = UserPreferences();

  // Controllers
  
  BehaviorSubject<List<UserRanking>> _userRankingListStreamController = BehaviorSubject<List<UserRanking>>();
  BehaviorSubject<bool> _needToUpdatePointsController = BehaviorSubject<bool>();

  // Streams
  // StreamSubscription<QuerySnapshot> get queryUserRankingStream => Firestore.instance.collection("userRanking").snapshots()
                                                      // .listen((querySnapshotUserRanking) {
                                                        // List<UserRanking> auxiliarUserRankingList = List<UserRanking>();
                                                        // querySnapshotUserRanking.documents.forEach((document) {
                                                        //   auxiliarUserRankingList.add(UserRanking.fromSnapshotData(document.data));
                                                        // });
                                                        // auxiliarUserRankingList.sort((userRankingA, userRankingB) => userRankingB.points.compareTo(userRankingA.points));

                                                        // changeUserRankingList(auxiliarUserRankingList);   
                                                      // });

  Stream<QuerySnapshot> get userStream => Firestore.instance.collection("user").snapshots();

  Stream<List<UserRanking>> get userRankingListStream => _userRankingListStreamController.stream;
  Stream<bool> get needToUpdatePointsStream => _needToUpdatePointsController.stream;

  // Inputs
  Function(List<UserRanking>) get changeUserRankingList => _userRankingListStreamController.sink.add;
  Function(bool) get changeNeedToUpdatePoints => _needToUpdatePointsController.sink.add;

  // Values
  List<UserRanking> get userRankingList => _userRankingListStreamController.value;
  bool get needToUpdatePoints => _needToUpdatePointsController.value;

  Future<void> createOrUpdateUserRanking() async {
    DocumentSnapshot response = await Firestore.instance.collection("userRanking").document(prefs.id).get();

    if (response.exists) {
      await Firestore.instance.collection("userRanking").document(prefs.id).updateData({
        "id" : prefs.id,
        "userId" : prefs.id,
        "username" : prefs.username,
        "userAvatar" : prefs.avatar,
      });
    } else {
      await Firestore.instance.collection("userRanking").document(prefs.id).setData({
        "id" : prefs.id,
        "userId" : prefs.id,
        "username" : prefs.username,
        "userAvatar" : prefs.avatar,
        "points" : 0.0,
        "position" : 0,
        "coins" : 0,
        "trivias" : List<String>(),
        "correctQuestions" : 0,
        "incorrectQuestions" : 0,
        "notPlayedQuestions" : 0
      });
    }
  }

  Future<void> addPointsByUserId(double mPointsQuantity) async {
    DocumentSnapshot response = await Firestore.instance.collection("userRanking").document(prefs.id).get();

    if (response.exists) {
      double currentScore = double.parse(response.data["points"].toString());
      currentScore = currentScore + mPointsQuantity;

      response.reference.updateData({
        "points" : currentScore.toDouble()
      });
    }
  }

  

  Future<int> getCurrentPosition() async {
    QuerySnapshot response = await Firestore.instance.collection("userRanking").getDocuments();

    List<DocumentSnapshot> listDocuments = response.documents;
    List<UserRanking> listUserRanking = List<UserRanking>();
    
    print(listDocuments.length);

    listDocuments.forEach((document) {
      listUserRanking.add(UserRanking.fromSnapshotData(document.data));
    });

    listUserRanking.sort((userRankingA, userRankingB) => userRankingB.points.compareTo(userRankingA.points));

    int newPosition = listUserRanking.indexWhere((userRanking) => userRanking.userId == prefs.id) + 1;
  
    await Firestore.instance.collection("userRanking").document(prefs.id).updateData({
      "position" : newPosition
    });

    return newPosition;
  }

  void dispose() {
    _userRankingListStreamController?.close();
  }
}

UserRankingBloc userRankingBloc = UserRankingBloc();
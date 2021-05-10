import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';

class ActiveTriviaBloc {

  static final _singleton = ActiveTriviaBloc._();

  factory ActiveTriviaBloc() => _singleton;

  ActiveTriviaBloc._();

  UserPreferences prefs = UserPreferences();

  // Streams 
  Stream<QuerySnapshot> get activeTriviaStream => Firestore.instance.collection('trivia')
                                                  .where("isActive", isEqualTo: true)
                                                  .snapshots();

  Stream<QuerySnapshot> get activeTriviaQuestionsStream => Firestore.instance.collection("activeTrivia").snapshots();

  Stream<DocumentSnapshot> get userTriviaAnswersStream => Firestore.instance.collection("userTriviaAnswers").document(prefs.id).snapshots();
}

ActiveTriviaBloc activeTriviaBloc = ActiveTriviaBloc();
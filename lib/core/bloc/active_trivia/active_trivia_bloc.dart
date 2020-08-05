import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ActiveTriviaBloc {

  static final _singleton = ActiveTriviaBloc._();

  factory ActiveTriviaBloc() => _singleton;

  ActiveTriviaBloc._();

  // Streams 
  Stream<QuerySnapshot> get activeTriviaStream => Firestore.instance.collection('trivias')
                                                  .where("isActive", isEqualTo: true)
                                                  .snapshots();
}

ActiveTriviaBloc activeTriviaBloc = ActiveTriviaBloc();
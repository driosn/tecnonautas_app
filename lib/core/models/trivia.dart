import 'package:cloud_firestore/cloud_firestore.dart';

class Trivia {

  final String id;  
  final String name;
  final String category;
  final String description;
  final int points;
  final int qtyPreg;
  final bool fav;
  final bool isActive;

  final Map<String, int> qtyResp;
  final Map<String, int> questionTime;
  final List<String> questions;
  final Map<String, String> respCorrect;
  final Map<String, Map<String, String>> responses;

  DocumentReference reference;

  Trivia({
    this.id,
    this.name,
    this.category,
    this.description,
    this.points,
    this.qtyPreg,
    this.fav,
    this.isActive,
    this.qtyResp,
    this.questionTime,
    this.questions,
    this.respCorrect,
    this.responses
  });

  Trivia.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['id'] != null),
       assert(map['name'] != null),
       assert(map['category'] != null),
       assert(map['description'] != null),
       assert(map['points'] != null),
       assert(map['qtyPreg'] != null),
       assert(map['fav'] != null),
       id = map['id'],
       name = map['name'],
       category = map['category'],
       description = map['description'],
       points = map['points'],
       qtyPreg = map['qtyPreg'],
       fav = map['fav'],
       isActive = map['isActive'],
       qtyResp = Map<String, int>.from(map["qtyresp"]),
       questionTime = Map<String, int>.from(map["questionTime"]),
       questions = List<String>.from(map["questions"]),
       respCorrect = Map<String, String>.from(map["respCorrect"]),
       responses = _generateResponsesMap(Map<String, dynamic>.from(map["responses"]), map["qtyPreg"]);

             

  Trivia.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Trivia<$name:$category:$description:$qtyPreg>";

  static Map<String, Map<String, String>> _generateResponsesMap(Map<String, dynamic> responses, int length) {
    Map<String, Map<String, String>> auxiliarMap = Map<String, Map<String, String>>();

    responses.forEach((key, value) {
      auxiliarMap.putIfAbsent(key, () => Map<String, String>.from(value));
    });

    return auxiliarMap;
  }
}
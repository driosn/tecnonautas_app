import 'package:cloud_firestore/cloud_firestore.dart';

class WebData {

  List<String> launchedQuestions;
  List<String> activeQuestions;
  List<String> selectedPowers;
  DocumentReference reference;

  WebData({
    this.launchedQuestions,
    this.activeQuestions,
    this.selectedPowers,
    this.reference
  });

  factory WebData.fromDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data;
    return WebData(
      launchedQuestions: List<String>.from(data["launchedQuestions"]),
      activeQuestions: List<String>.from(data["activeQuestions"]),
      selectedPowers: List<String>.from(data["selectedPowers"]),
      reference: snapshot.reference
    );
  }
}
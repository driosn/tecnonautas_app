import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tecnonautas_app/core/models/web_data.dart';

class WebDataBloc {

  static final WebDataBloc _singleton = WebDataBloc._internal();

  factory WebDataBloc() => _singleton;

  WebDataBloc._internal();

  // Firestore Web Data
  Stream<QuerySnapshot> get webDataStream => Firestore.instance.collection('webData').snapshots();

  Future<WebData> fetchWebData() async {
    QuerySnapshot snapshot = await Firestore.instance.collection("webData").getDocuments();
    return WebData.fromDocument(snapshot.documents.first);
  }
}

WebDataBloc webDataBloc = WebDataBloc();
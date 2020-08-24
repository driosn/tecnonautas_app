import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';

class SelectedActiveTriviaBloc {

  static final _singleton = SelectedActiveTriviaBloc._internal();

  factory SelectedActiveTriviaBloc() => _singleton;

  SelectedActiveTriviaBloc._internal();

  UserPreferences prefs = UserPreferences();

  // Controllers
  BehaviorSubject<Trivia> _selectedActiveTriviaController = BehaviorSubject<Trivia>();

  // Streams
  Stream<Trivia> get selectedActiveTriviaStream => _selectedActiveTriviaController.stream;
  
  // Inputs
  Function(Trivia) get changeSelectedActiveTrivia => _selectedActiveTriviaController.sink.add;

  // Values
  Trivia get selectedActiveTrivia => _selectedActiveTriviaController.value;

  // Firestore
  

  Future<void> playActiveTrivia() async {
    List<Map<String, dynamic>> answersList = List<Map<String, dynamic>>();

    try {
      bool existsTriviaPlayed = false;


      final document = await Firestore.instance.collection("userTriviaAnswers").document(prefs.id).get();
      if (document.exists) {
        final data = document.data;
        if (data.containsKey("answers")) {
          List<dynamic> auxList = data["answers"];
          List<Map<String, dynamic>> auxMapList = List<Map<String, dynamic>>();
          auxList.forEach((element) {
            existsTriviaPlayed = element["triviaName"] == selectedActiveTrivia.name;
            auxMapList.add(Map<String, dynamic>.from(element));
          });

          answersList.addAll(auxMapList);
        }
      }

      if (!existsTriviaPlayed) answersList.add(generateNewTriviaPlay());

      if (document.exists) {
        await document.reference.updateData({
          "answers" : answersList
        });
      } else {
        await Firestore.instance.collection("userTriviaAnswers").document(prefs.id).setData({
          "answers" : answersList
        });
      } 
    } catch(error) {
      print(error.toString());
    }
      
    // await Firestore.instance.collection("userTriviaAnswers").document()
  }

  Map<String, dynamic> generateNewTriviaPlay() => {
    "triviaName" : this.selectedActiveTrivia.name,
    "responses" : generateVoidResponsesMap(),
    "scores" : generateVoidScoresMap(),
    "totalScore" : 0.0
  };

  Map<String, dynamic> generateVoidResponsesMap() {
    Map<String, dynamic> auxiliarMap = Map<String, dynamic>();
    
    this.selectedActiveTrivia.questions.forEach((question) {
      auxiliarMap.putIfAbsent(question, () => "");
    });
    return auxiliarMap;
  }

  Map<String, double> generateVoidScoresMap() {
    Map<String, double> auxiliarMap = Map<String, double>();

    this.selectedActiveTrivia.questions.forEach((question) {
      auxiliarMap.putIfAbsent(question, () => 0.0);
    });
    return auxiliarMap;
  }

  void dispose() {
    _selectedActiveTriviaController?.close();
  }
}

SelectedActiveTriviaBloc selectedActiveTriviaBloc = SelectedActiveTriviaBloc();
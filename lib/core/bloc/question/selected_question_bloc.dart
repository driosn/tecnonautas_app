import 'package:rxdart/rxdart.dart';
import 'package:tecnonautas_app/core/models/question.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';

class SelectedQuestionBloc {

  static final _singleton = SelectedQuestionBloc._internal();

  factory SelectedQuestionBloc() => _singleton;

  SelectedQuestionBloc._internal();

  // Controllers
  BehaviorSubject<Trivia> _parentTriviaController = BehaviorSubject<Trivia>();
  BehaviorSubject<Question> _selectedQuestionController = BehaviorSubject<Question>();

  // Streams
  Stream<Trivia> get parentTriviaStream => _parentTriviaController.stream;
  Stream<Question> get selectedQuestionStream => _selectedQuestionController.stream;

  // Inputs
  Function(Trivia) get changeParentTrivia => _parentTriviaController.sink.add;
  Function(Question) get changeSelectedQuestion => _selectedQuestionController.sink.add;

  // Values
  Trivia get parentTrivia => _parentTriviaController.value;
  Question get selectedQuestion => _selectedQuestionController.value;

  void dispose() {
    _parentTriviaController?.close();
    _selectedQuestionController?.close();
  }
}

SelectedQuestionBloc selectedQuestionBloc = SelectedQuestionBloc();
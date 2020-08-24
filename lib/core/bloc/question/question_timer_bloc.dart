import 'package:rxdart/rxdart.dart';

class QuestionTimerBloc {

  final BehaviorSubject<bool> _isCompletedController = new BehaviorSubject<bool>();
  final BehaviorSubject<String> _selectedQuestionController = new BehaviorSubject<String>();

  // Streams
  Stream<bool> get isCompletedStream => _isCompletedController.stream; 
  Stream<String> get selectedQuestionStream => _selectedQuestionController.stream;

  // Inputs
  Function(bool) get changeIsCompleted => _isCompletedController.sink.add;
  Function(String) get changeSelectedQuestion => _selectedQuestionController.sink.add;

  // Values
  bool get isCompleted => _isCompletedController.value;
  String get selectedQuestion => _selectedQuestionController.value;

  void dispose() {
    _isCompletedController?.close();
    _selectedQuestionController?.close();
  }

}
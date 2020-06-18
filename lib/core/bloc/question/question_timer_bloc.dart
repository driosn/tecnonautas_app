import 'package:rxdart/rxdart.dart';

class QuestionTimerBloc {

  final BehaviorSubject<bool> _isCompletedController = new BehaviorSubject<bool>();

  // Streams
  Stream<bool> get isCompletedStream => _isCompletedController.stream; 

  // Inputs
  Function(bool) get changeIsCompleted => _isCompletedController.sink.add;

  // Values
  bool get isCompleted => _isCompletedController.value;

  void dispose() {
    _isCompletedController?.close();
  }

}
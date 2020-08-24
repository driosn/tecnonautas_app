import 'package:rxdart/subjects.dart';

enum AuthOption {
  LOGIN,
  REGISTER
}

class AuthBloc {

  static final AuthBloc instance = AuthBloc._internal();

  factory AuthBloc() => instance;

  AuthBloc._internal();

  // Controllers
  BehaviorSubject<AuthOption> _authOptionController = BehaviorSubject<AuthOption>();

  // Streams
  Stream<AuthOption> get authOptionStream => _authOptionController.stream;

  // Inputs
  Function(AuthOption) get changeAuthOption => _authOptionController.sink.add;

  // Value
  AuthOption get authOption => _authOptionController.value;

  void dispose() {
    _authOptionController?.close();
  }

}

AuthBloc authBloc = AuthBloc();
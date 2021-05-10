import 'package:rxdart/rxdart.dart';
import 'package:tecnonautas_app/core/models/db_local_trivia.dart';
import 'package:tecnonautas_app/src/utils/db_provider.dart';

class LocalTriviasBloc {

  static final LocalTriviasBloc _singleton = LocalTriviasBloc._internal();

  LocalTriviasBloc._internal();

  factory LocalTriviasBloc() => _singleton;

  final _localTriviasController = BehaviorSubject<List<DBLocalTrivia>>();

  Stream<List<DBLocalTrivia>> get localTriviasStream => _localTriviasController.stream;

  set localTrivias(value) => _localTriviasController.sink.add(value);

  List<DBLocalTrivia> get localTrivias => _localTriviasController.value;

  void reloadTrivias() async {
    final response = await DBProvider.db.readLocalTrivias();
    localTrivias = response;
  }

  void setTriviaToComplete(int id) async {
    await DBProvider.db.setTriviaToPlayed(id);
    reloadTrivias();
  }

  void dispose() {
    _localTriviasController?.close();
  }

}

LocalTriviasBloc localTriviasBloc = LocalTriviasBloc();
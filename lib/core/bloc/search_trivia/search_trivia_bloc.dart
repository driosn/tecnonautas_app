import 'package:rxdart/subjects.dart';

enum FilterType {
  PLAYED, FAVORITE, NONE
}

class SearchTriviaBloc {

  static final SearchTriviaBloc _singleton = SearchTriviaBloc._internal();

  factory SearchTriviaBloc() => _singleton;

  SearchTriviaBloc._internal();

  final BehaviorSubject<String> _searchTriviaController = BehaviorSubject<String>();
  final BehaviorSubject<FilterType> _filterTypeController = BehaviorSubject<FilterType>();

  // Streams
  Stream<String> get searchTriviaStream => _searchTriviaController.stream;
  Stream<FilterType> get filterTypeStream => _filterTypeController.stream;

  // Input
  Function(String) get changeSearchTrivia => _searchTriviaController.sink.add;
  Function(FilterType) get changeFilterType => _filterTypeController.sink.add;

  // Values
  String get searchTrivia => _searchTriviaController.value;
  FilterType get filterType => _filterTypeController.value;

  void dispose() {
    _searchTriviaController?.close();
    _filterTypeController?.close();
  }
}

SearchTriviaBloc searchTriviaBloc = SearchTriviaBloc();
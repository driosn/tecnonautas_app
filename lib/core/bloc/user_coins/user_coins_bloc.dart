import 'package:rxdart/rxdart.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';

class UserCoinsBloc {

  static final UserCoinsBloc _userCoinsBloc = UserCoinsBloc._internal();

  static UserPreferences prefs = UserPreferences();

  UserCoinsBloc._internal();
  
  factory UserCoinsBloc() {
   _userCoinsBloc.changeCoins(prefs.userCoins);
   return _userCoinsBloc;
  }

  // Controlleres
  BehaviorSubject<int> _coinsController = BehaviorSubject<int>();

  // Streams
  Stream<int> get coinsStream => _coinsController.stream;

  // Inputs
  Function(int) get changeCoins => _coinsController.sink.add;

  // Values
  int get coins => _coinsController.value;

  void addFiveCoins() {
    int currentNumber = prefs.userCoins;
    currentNumber = currentNumber + 5;
    this.changeCoins(currentNumber);
    prefs.updateUserCoins(mNewCoins: currentNumber);
  }

  void minusFiveCoins() {
    int currentNumber = prefs.userCoins;
    if (currentNumber < 5) {
      this.changeCoins(0);
      prefs.updateUserCoins(mNewCoins: 0);
    } else {
      currentNumber = currentNumber - 5;
      this.changeCoins(currentNumber);
      prefs.updateUserCoins(mNewCoins: currentNumber);
    }
  }

  void dispose() {
    _coinsController?.close();
  }
}

UserCoinsBloc userCoinsBloc = UserCoinsBloc();

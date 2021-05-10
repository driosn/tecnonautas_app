import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/password.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tecnonautas_app/core/models/user.dart';

class LoginBloc {

  // Controllers
  BehaviorSubject<String> _usernameController = BehaviorSubject<String>();
  BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  // Streams
  Stream<String> get usernameStream => _usernameController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

  // Inputs
  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Values
  String get username => _usernameController.value;
  String get password => _passwordController.value;

  Future<User> checkUserLogin() async {
    QuerySnapshot response = await Firestore.instance
                                      .collection("user")
                                      .where("username", isEqualTo: username)
                                      .getDocuments();
    

    if (response.documents.length > 0) {
      DocumentSnapshot document = response.documents.first;
      // bool correctPassword = Password.verify(password, document.data["password"]);
      if (encodePassword(password) == document.data["password"]) {
        return User.fromDocument(document.data);
      }
      return null;
    }
    return null;
  }

  String encodePassword(String currentPassword) {
    String encodedPassword = "";
    for(int i = 0; i < currentPassword.length; i++) {
      encodedPassword += String.fromCharCode(currentPassword.codeUnitAt(i) + 1);
    }
    return encodedPassword;
  }

  void dispose() {
    _usernameController?.close();
    _passwordController?.close();
  }

}
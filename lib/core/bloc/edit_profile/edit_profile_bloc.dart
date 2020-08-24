import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';

class EditProfileBloc {

  UserPreferences prefs = UserPreferences();

  // controllers
  BehaviorSubject<String> _avatarController = BehaviorSubject<String>();
  BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  BehaviorSubject<String> _lastnameController = BehaviorSubject<String>();
  BehaviorSubject<String> _birthdateController = BehaviorSubject<String>();
  BehaviorSubject<String> _cityController = BehaviorSubject<String>();
  BehaviorSubject<int> _phoneController = BehaviorSubject<int>();

  // Streams
  Stream<String> get avatarStream => _avatarController.stream;
  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get lastnameStream => _lastnameController.stream;
  Stream<String> get birthdateStream => _birthdateController.stream;
  Stream<String> get cityStream => _cityController.stream;
  Stream<int> get phoneStream => _phoneController.stream;

  // Inputs
  Function(String) get changeAvatar => _avatarController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastname => _lastnameController.sink.add;
  Function(String) get changeBirthdate => _birthdateController.sink.add;
  Function(String) get changeCity => _cityController.sink.add;
  Function(int) get changePhone => _phoneController.sink.add;

  // Values
  String get avatar => _avatarController.value;
  String get name => _nameController.value;
  String get lastname => _lastnameController.value;
  String get birthdate => _birthdateController.value;
  String get city => _cityController.value;
  int get phone => _phoneController.value;

  Future<bool> updateProfile() async {
    await Firestore.instance.collection("users").document(prefs.id).updateData({
      "avatar" : this.avatar,
      "name" : this.name,
      "lastname" : this.lastname,
      "birthdate" : this.birthdate,
      "city" : this.city,
      "phone" : this.phone
    });

    prefs.updateAvatar(this.avatar);
    prefs.updateName(this.name);
    prefs.updateLastname(this.lastname);
    prefs.updateBirthdate(this.birthdate);  
    prefs.updateCity(this.city);
    prefs.updatePhone(this.phone.toString());

    return true;
  }

  void dispose() {
    _avatarController?.close();
    _nameController?.close();
    _lastnameController?.close();
    _birthdateController?.close();
    _cityController?.close();
    _phoneController?.close();
  }
}
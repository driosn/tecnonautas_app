import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecnonautas_app/core/models/user.dart';

class UserPreferences {

  static final _singleton = UserPreferences._();

  factory UserPreferences() => _singleton;

  UserPreferences._();

  SharedPreferences _prefs;

  initPreferences() async {
    this._prefs = await SharedPreferences.getInstance();
  } 

  // User fields

  String get id {
    return _prefs.getString("id") ?? null;
  }

  String get name {
    return _prefs.getString("name") ?? null;
  }

  String get lastname {
    return _prefs.getString("lastname") ?? null;
  }

  String get username {
    return _prefs.getString("username") ?? null;
  }

  String get birthdate {
    return _prefs.getString("birthdate") ?? null;
  }

  String get phone {
    return _prefs.getString("phone") ?? null;
  }

  String get grade {
    return _prefs.getString("grade") ?? null;
  }

  String get avatar {
    return _prefs.getString("avatar") ?? null;
  }

  String get city {
    return _prefs.getString("city") ?? null;
  }

  bool get isValidated {
    return _prefs.getBool("is_validated") ?? false;
  }

  void updateId(String mValue) {
    _prefs.setString("id", mValue);
  }

  void updateName(String mValue) {
    _prefs.setString("name", mValue);
  }

  void updateLastname(String mValue) {
    _prefs.setString("lastname", mValue);
  }

  void updateUsername(String mValue) {
    _prefs.setString("username", mValue);
  }

  void updateBirthdate(String mValue) {
    _prefs.setString("birthdate", mValue);
  }

  void updatePhone(String mValue) {
    _prefs.setString("phone", mValue);
  }

  void updateGrade(String mValue) {
    _prefs.setString("grade", mValue);
  }

  void updateAvatar(String mValue) {
    _prefs.setString("avatar", mValue);
  }

  void updateCity(String mValue) {
    _prefs.setString("city", mValue);
  }

  void updateIsValidated(bool mValue) {
    _prefs.setBool("is_validated", mValue);
  }

  void updateCompleteUser(User mUser) {
    updateId(mUser.id);
    updateName(mUser.name);
    updateLastname(mUser.lastname);
    updateUsername(mUser.username);
    updateBirthdate(mUser.birthdate);
    updatePhone(mUser.phone);
    updateGrade(mUser.grade);
    updateAvatar(mUser.avatar);
    updateCity(mUser.city);
    updateIsValidated(mUser.isValidated);
  }

  void deleteUser() {
    updateId(null);
    updateName(null);
    updateLastname(null);
    updateUsername(null);
    updateBirthdate(null);
    updatePhone(null);
    updateGrade(null);
    updateAvatar(null);
    updateCity(null);
    updateIsValidated(null);
  }
  
}
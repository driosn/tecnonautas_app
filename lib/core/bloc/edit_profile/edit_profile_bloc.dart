import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/utils/utils.dart';
import 'package:tecnonautas_app/src/utils/validators.dart';

class EditProfileBloc with Validators {

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
  Stream<String> get nameStream => _nameController.stream.transform(validateEmptyString);
  Stream<String> get lastnameStream => _lastnameController.stream.transform(validateEmptyString);
  Stream<String> get birthdateStream => _birthdateController.stream;
  Stream<String> get cityStream => _cityController.stream.transform(validateEmptyString);
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

  Stream<bool> get correctFormDataStream => Rx.combineLatest5(
    nameStream, 
    lastnameStream,
    birthdateStream, 
    cityStream,
    phoneStream,
    (a, b, c, d, e) => true
  );

  Future<bool> updateProfile() async {
    await Firestore.instance.collection("user").document(prefs.id).updateData({
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

  Future<void> editProfile() async {
    Utils _utils = Utils();
    UserPreferences prefs = UserPreferences();
    if (_stringNotHasNumber(name) && _stringNotHasNumber(lastname)) {
      if ((this.phone.toString().length == 8 || this.phone.toString().length == 7) && _utils.isNumeric(this.phone.toString())) {
        await updateProfile();  
      } else {
        throw new Exception("El numero de celular debe ser correcto");
      }
    } else {
      throw new Exception("El nombre y apellido no deben contener números");
    }
  }

  bool _stringNotHasNumber(String mValue) {
    for(int i = 0; i < mValue.length; i++) {
      int charCode = mValue.codeUnitAt(i);
      if (charCode >= 48 && charCode <= 57) return false;
    }
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
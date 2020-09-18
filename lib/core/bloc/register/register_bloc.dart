import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password/password.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tecnonautas_app/src/utils/validators.dart';
import 'package:uuid/uuid.dart';

class RegisterBloc with Validators {

  static final instance = RegisterBloc._internal();

  factory RegisterBloc() => instance;

  RegisterBloc._internal();

  Uuid _uuid = Uuid();

  // Controllers 
  BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  BehaviorSubject<String> _lastnameController = BehaviorSubject<String>();
  BehaviorSubject<String> _nicknameController = BehaviorSubject<String>();
  BehaviorSubject<String> _birthdateController = BehaviorSubject<String>();
  BehaviorSubject<String> _phoneController = BehaviorSubject<String>();
  BehaviorSubject<String> _gradeController = BehaviorSubject<String>();
  BehaviorSubject<String> _avatarController = BehaviorSubject<String>();
  BehaviorSubject<String> _cityController = BehaviorSubject<String>();  
  BehaviorSubject<bool> _isLoadingController = BehaviorSubject<bool>();

  // Streams
  Stream<String> get nameStream => _nameController.stream.transform(validateEmptyString);
  Stream<String> get passwordStream => _passwordController.stream.transform(validateEmptyString);
  Stream<String> get lastnameStream => _lastnameController.stream.transform(validateEmptyString);
  Stream<String> get nicknameStream => _nicknameController.stream.transform(validateEmptyString);
  Stream<String> get birthdateStream => _birthdateController.stream;
  Stream<String> get phoneStream => _phoneController.stream.transform(validateEmptyString);
  Stream<String> get gradeStream => _gradeController.stream.transform(validateEmptyString);
  Stream<String> get avatarStream => _avatarController.stream;
  Stream<String> get cityStream => _cityController.stream.transform(validateEmptyString);
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  // Inputs
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeLastname => _lastnameController.sink.add;
  Function(String) get changeNickname => _nicknameController.sink.add;
  Function(String) get changeBirthdate => _birthdateController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeGrade => _gradeController.sink.add;
  Function(String) get changeAvatar => _avatarController.sink.add;
  Function(String) get changeCity => _cityController.sink.add;
  Function(bool) get changeIsLoading => _isLoadingController.sink.add;

  // Value
  String get name => _nameController.value;
  String get password => _passwordController.value;
  String get lastname => _lastnameController.value;
  String get nickname => _nicknameController.value;
  String get birthdate => _birthdateController.value;
  String get phone => _phoneController.value;
  String get grade => _gradeController.value;
  String get avatar => _avatarController.value;
  String get city => _cityController.value;
  bool get isLoading => _isLoadingController.value;

  // Custom Streams
  Stream<bool> get correctFormDataStream => Rx.combineLatest9(
    nameStream, 
    passwordStream,
    lastnameStream, 
    nicknameStream, 
    birthdateStream, 
    phoneStream, 
    gradeStream, 
    avatarStream, 
    cityStream, 
    (a, b, c, d, e, f, g, h, i) => true
  );

  Future<void> createNewUser() async {
    String uniqueId = _uuid.v1();

    Firestore.instance.collection("users").document(uniqueId).setData({
      "id" : uniqueId,
      "name" : this.name,
      "password" : Password.hash(this.password, new PBKDF2()),
      "lastname" : this.lastname,
      "username" : this.nickname,
      "birthdate" : this.birthdate,
      "phone" : this.phone,
      "grade" : this.grade,
      "avatar" : this.avatar,
      "city" : this.city,
      "isValidated" : false
    });


    // await Firestore.instance.collection("users").add({
    //   "id" : _uuid.v1(),
    //   "name" : this.name,
    //   "password" : Password.hash(this.password, new PBKDF2()),
    //   "lastname" : this.lastname,
    //   "username" : this.nickname,
    //   "birthdate" : this.birthdate,
    //   "phone" : this.phone,
    //   "grade" : this.grade,
    //   "avatar" : this.avatar,
    //   "city" : this.city,
    //   "isValidated" : false
    // });
  }

  void dispose() {
    _nameController?.close();
    _passwordController?.close();
    _lastnameController?.close();
    _nicknameController?.close();
    _birthdateController?.close();
    _phoneController?.close();
    _gradeController?.close();
    _avatarController?.close();
    _cityController?.close();
  }
}

RegisterBloc registerBloc = RegisterBloc();
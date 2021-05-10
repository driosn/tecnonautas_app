import 'dart:async';

import 'package:tecnonautas_app/src/utils/utils.dart';

class Validators {

  static final emptyLbl = "Este campo no puede estar vacio";

  final validateEmptyString = StreamTransformer<String, String>.fromHandlers(
    handleData: (input, sink) {
      if (input.isNotEmpty) {
        sink.add(input);
      } else {
        sink.addError(emptyLbl);
      }
    }
  );

  //
  // Form Validators
  //
  static String nameValidator(String mName) {
    if (mName.isEmpty) return emptyLbl;
    if (!_stringNotHasNumber(mName)) return "El nombre no puede contener valores numéricos";
    return null;
  }

  static String passwordValidator(String mPassword) {
    if (mPassword.isEmpty) return emptyLbl;
    if (mPassword.length < 8) return "La contraseña debe contener minimamente 8 caracteres";
    return null;
  }

  static String phoneValidator(String mPhone) {
    if (mPhone.isEmpty) return emptyLbl;
    if (!Utils().isNumeric(mPhone) || mPhone.length < 8) return "El celular debe ser un número de 8 digitos";
    return null;
  }

  static bool _stringNotHasNumber(String mValue) {
    for(int i = 0; i < mValue.length; i++) {
      int charCode = mValue.codeUnitAt(i);
      if (charCode >= 48 && charCode <= 57) return false;
    }
    return true;
  }

}
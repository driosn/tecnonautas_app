import 'dart:async';

class Validators {

  final validateEmptyString = StreamTransformer<String, String>.fromHandlers(
    handleData: (input, sink) {
      if (input.isNotEmpty) {
        sink.add(input);
      } else {
        sink.addError("Este campo no puede estar vacío");
      }
    }
  );

}
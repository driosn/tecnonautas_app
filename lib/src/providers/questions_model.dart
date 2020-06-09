import 'package:flutter/material.dart';

class QuestionsModel with ChangeNotifier {

  bool _isCounter = true;

  bool get isCounter => this._isCounter;

  set isCounter(bool value) {
    this._isCounter = value;
    notifyListeners();
  } 
  
}
import 'package:flutter/material.dart';

class PortalHomeModel with ChangeNotifier {

  bool _isTriviasPage = false;
  int _selectedNavbarIndex = 0;

  get isTriviasPage => this._isTriviasPage;

  set isTriviasPage(bool value) {
    this._isTriviasPage = value;
    notifyListeners();
  }

  get selectedNavbarIndex => this._selectedNavbarIndex;

  set selectedNavbarIndex(int value) {
    this._selectedNavbarIndex = value;
    notifyListeners();
  }

}
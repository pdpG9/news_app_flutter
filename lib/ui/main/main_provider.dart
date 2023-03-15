import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  var _index = 0;
  var _oldSelected = 0;

  void onChangeTab(int index) {
    _oldSelected = _index;
    _index = index;
    notifyListeners();
  }

  int get index => _index;

  int get oldSelected => _oldSelected;
}

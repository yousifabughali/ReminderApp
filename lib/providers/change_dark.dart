import 'package:flutter/material.dart';

class ChangeDark extends ChangeNotifier{
  bool isDark=false;

  changeTheme(bool value) {
    isDark = value;
    notifyListeners();
  }

}
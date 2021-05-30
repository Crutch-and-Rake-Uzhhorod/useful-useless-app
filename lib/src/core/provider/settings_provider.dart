import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool switchState = true;

  void getNotification() {
    switchState = !switchState;
    notifyListeners();
  }
}

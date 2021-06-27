import 'package:flutter/material.dart';

import '../repository/auth_repository.dart';
import '../repository/data_repository.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider({
    required DataRepository dataRepository,
    required AuthRepository authRepository,
  })  : _dataRepository = dataRepository,
        _authRepository = authRepository;

  final DataRepository _dataRepository;
  final AuthRepository _authRepository;

  bool _switchState = true;

  bool get switchState => _switchState;

  void getNotification() {
    _switchState = !_switchState;

    final user = _authRepository.currentUser;
    if (user != null && !user.isAnonymous) {
      _dataRepository.updateNotificationPreference(
        user.uid,
        _switchState,
      );
    }
    notifyListeners();
  }
}

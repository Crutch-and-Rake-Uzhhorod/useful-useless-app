import 'package:flutter/material.dart';

import '../repository/user_auth_repository.dart';
import '../repository/user_data_repository.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider({
    required UserDataRepository userDataRepository,
    required UserAuthRepository userAuthRepository,
  })  : _userDataRepository = userDataRepository,
        _userAuthRepository = userAuthRepository;

  final UserDataRepository _userDataRepository;
  final UserAuthRepository _userAuthRepository;

  bool _switchState = true;

  bool get switchState => _switchState;

  void getNotification() {
    _switchState = !_switchState;

    final user = _userAuthRepository.currentUser;
    if (user != null && !user.isAnonymous) {
      _userDataRepository.updateNotificationPreference(
        user.uid,
        _switchState,
      );
    }
    notifyListeners();
  }
}

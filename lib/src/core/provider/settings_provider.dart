import 'package:flutter/material.dart';

import '../repository/data_repository.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider({
    required DataRepository dataRepository,
  }) : _dataRepository = dataRepository;

  final DataRepository _dataRepository;

  bool _switchState = true;

  bool get switchState => _switchState;

  Future<void> getNotification() async {
    final result = await _dataRepository.updateNotificationPreference(
      _switchState,
    );

    if (result) {
      _switchState = !_switchState;

      notifyListeners();
    }
  }
}

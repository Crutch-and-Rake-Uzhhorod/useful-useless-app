import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../repository/user_repository.dart';

class UserProvider with ChangeNotifier {
  UserProvider({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  User? _user;

  bool isIphone = false;

  bool isUserLoggedIn() {
    _user = _userRepository.currentUser();

    return _user != null;
  }

  // TODO: to handle dismiss by user etc.
  Future<void> signInWithGoogle() async {
    try {
      _user = await _userRepository.signInWithGoogle();
    } catch (_) {}
  }

  Future<bool> checkIsAppleSignInAvailable() async {
    isIphone = await SignInWithApple.isAvailable();
    return isIphone;
  }
}

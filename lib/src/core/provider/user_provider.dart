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

  bool userLoggedIn() {
    _user = _userRepository.currentUser();

    return _user != null;
  }

  // TODO: to handle dismiss by user etc.
  Future<void> signInWithGoogle() async {
    _user = await _userRepository.signInWithGoogle();
  }

  Future<bool> checkIsAppleSignInAvailable() async {
    isIphone = await SignInWithApple.isAvailable();
    return isIphone;
  }
}

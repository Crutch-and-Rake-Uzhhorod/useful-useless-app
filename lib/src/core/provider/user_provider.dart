import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../repository/user_repository.dart';

class UserProvider with ChangeNotifier {
  UserProvider({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  bool isIphone = false;

  User? _user;

  User? get user => _user;

  bool isUserLoggedIn() {
    _user = _userRepository.currentUser;

    return _user != null;
  }

  // TODO: to handle dismiss by user etc.
  Future<void> signInWithGoogle() async {
    _user = await _userRepository.signInWithGoogle();
  }

  Future<bool> checkIsAppleSignInAvailable() async {
    if (kIsWeb) {
      return false;
    }
    isIphone = await SignInWithApple.isAvailable();

    return isIphone;
  }

  Future<void> signOut() async {
    await _userRepository.signOut();
  }
}

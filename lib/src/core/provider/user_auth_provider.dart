import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../repository/user_auth_repository.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserAuthProvider with ChangeNotifier {
  UserAuthProvider({
    required UserAuthRepository userAuthRepository,
  }) : _userAuthRepository = userAuthRepository;

  final UserAuthRepository _userAuthRepository;

  // bool isIphone = false;

  User? get user => _userAuthRepository.currentUser;

  bool isUserLoggedIn() {
    return user != null;
  }

  Future<User?> signInWithGoogle() async {
    return await _userAuthRepository.signInWithGoogle();
  }

  Future<User?> signInAnonymously() async {
    return await _userAuthRepository.signInAnonymously();
  }

  //to a better days
  // Future<bool> checkIsAppleSignInAvailable() async {
  //   if (kIsWeb) {
  //     return false;
  //   }
  //   isIphone = await SignInWithApple.isAvailable();
  //
  //   return isIphone;
  // }

  Future<void> signOut() async {
    await _userAuthRepository.signOut();
  }
}

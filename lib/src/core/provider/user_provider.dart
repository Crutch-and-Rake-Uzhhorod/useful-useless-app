import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:useful_useless_app/src/core/repository/user_repository.dart';

enum AuthState {
  // ignore: constant_identifier_names
  UN_AUTHENTICATED,
  // ignore: constant_identifier_names
  AUTHENTICATED,
  // UN_REGISTERED,
}
class UserProvider with ChangeNotifier{
  final _repository = UserRepository();
  User user;
  AuthState authState = AuthState.UN_AUTHENTICATED;

  Future<bool> tryAutoLogin() async {
    //await Future.delayed(Duration(seconds:3)); // fake function to simulate rest API request to firebase for development usege only when Auth proces not set up.
    //user = null; // _repository need to be
    user = await _repository.currentUser();

    if (user != null) {
      authState = AuthState.AUTHENTICATED;
      print("AutoAUTHENTICATED");
    }
    return user != null;
  }

  Future<bool> checkIsAppleSignInAvailable() async {
    return await AppleSignIn.isAvailable();
  }

}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthState {
  // ignore: constant_identifier_names
  UN_AUTHENTICATED,
  // ignore: constant_identifier_names
  AUTHENTICATED,
  // UN_REGISTERED,
}
class UserProvider with ChangeNotifier{
  // final _repository = UserRepository();
  User user;
  AuthState authState = AuthState.UN_AUTHENTICATED;

  Future<bool> tryAutoLogin() async {
    await Future.delayed(Duration(seconds:3)); // fake function to simulate rest API request to firebase for development usege only when Auth proces not set up.
    user = null; // _repository need to be

    if (user != null) {
      authState = AuthState.AUTHENTICATED;
    }return user != null;
  }
}

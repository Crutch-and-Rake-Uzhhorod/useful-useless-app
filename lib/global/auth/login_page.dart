import 'package:flutter/material.dart';

import 'package:useful_useless_app/global/auth/sign_in.dart';
import 'package:useful_useless_app/ui/custometabbar.dart';

import 'package:firebase_auth/firebase_auth.dart';

enum AuthState {
  UN_AUTHENTICATED,
  AUTHENTICATED,
  // UN_REGISTERED,
}

class UserProvider with ChangeNotifier {
  // final _repository = UserRepository();
  User user;
  AuthState authState = AuthState.UN_AUTHENTICATED;

  Future<bool> tryAutoLogin() async {
    await Future.delayed(Duration(seconds:3)); // fake function to simulate rest API request to firebase for development usege only when Auth proces not set up.
    user = null; // _repository need to be

    if (user != null) {
      authState = AuthState.AUTHENTICATED;
      print('dsdlspdlsdksl');
    }return user != null;
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return CustomeTabBar();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/google_logo.png'), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/services/firebase_auth_service.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Spacer(
                flex: 4,
              ),
              Image(
                image: AssetImage('assets/logo.jpg'),
                height: 150.0,
              ),
              Spacer(
                flex: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: _signInButton(
                      onTap: () {
                        if (Platform.isIOS) {
                          ///for iOS
                        } else {
                          Navigator.pushNamed(context, HomeScreen.id);
                        }
                      },
                      child: Platform.isIOS
                          ? SvgPicture.asset(
                              'assets/icons/apple.svg',
                              height: 50,
                            )
                          : Text(
                              'Anonymous\nSign In',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: _signInButton(
                      onTap: () {
                        FirebaseAuthService().signInWithGoogle().whenComplete(
                          () {
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.id);
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/google.svg',
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              if (Platform.isIOS)
                _signInButton(
                  onTap: () => Navigator.pushNamed(context, HomeScreen.id),
                  child: Text(
                    'Anonymous Sign In',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 24, color: Colors.black),
                  ),
                ),
              Spacer(
                flex: Platform.isIOS ? 2 : 4,
              ),
              TextButton(
                onPressed: () async => await _termsConditionsLink(),
                child: Text(
                  'Term & Conditions',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _termsConditionsLink() async {
    const url = 'https://github.com/Crutch-and-Rake-Uzhhorod/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _signInButton({Widget? child, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
            //maxWidth: double.infinity,
            //minWidth: 150,
            ),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, 9),
              blurRadius: 20,
              spreadRadius: 0.1,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/provider/user_provider.dart';
import '../global/rounded_button_widget.dart';
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
                    child: RoundedButtonWidget(
                      onTap: () {
                        if (Platform.isIOS) {
                          ///for iOS
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            HomeScreen.id,
                          );
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
                    child: RoundedButtonWidget(
                      onTap: () {
                        Provider.of<UserProvider>(
                          context,
                          listen: false,
                        ).signInWithGoogle().whenComplete(() {
                          Navigator.pushReplacementNamed(
                            context,
                            HomeScreen.id,
                          );
                        });
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
                RoundedButtonWidget(
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
}

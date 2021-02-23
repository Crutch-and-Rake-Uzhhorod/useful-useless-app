import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/provider/user_provider.dart';
import '../core/services/firebase_auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('assets/logo.jpg'), height: 150.0),
              SizedBox(height: 50),
              FutureBuilder(
                future: userProvider.checkIsAppleSignInAvailable(),
                builder: (ctx, checkIsAppleSignInAvailableSnapshot) {
                  if (!checkIsAppleSignInAvailableSnapshot.hasData) {
                    return Container(
                      child: Text('Loading...'),
                    ); //TODO: progress indicator/progress animation
                  }
                  return checkIsAppleSignInAvailableSnapshot.data
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                                  child: IconButton(
                                    icon: Icon(
                                      MdiIcons.apple,
                                      size: 70,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: IconButton(
                                    onPressed: () {
                                      FirebaseAuthService()
                                          .signInWithGoogle()
                                          .whenComplete(
                                        () {
                                          Navigator.pushReplacementNamed(
                                              context, HomeScreen.id);
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      MdiIcons.googlePlus,
                                      size: 80,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : IconButton(
                          onPressed: () {
                            FirebaseAuthService()
                                .signInWithGoogle()
                                .whenComplete(
                              () {
                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.id);
                              },
                            );
                          },
                          icon: Icon(
                            MdiIcons.googlePlus,
                            size: 80,
                          ),
                        );
                },
              ),
              SizedBox(height: 50),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
                child: Text(
                  'Anonymous SignIn',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
              SizedBox(height: 50),
              FlatButton(
                onPressed: () async {
                  const url = 'https://github.com/Crutch-and-Rake-Uzhhorod/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text(
                  'Term & Conditions',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

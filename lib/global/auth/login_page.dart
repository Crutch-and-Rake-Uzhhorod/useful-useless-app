import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:useful_useless_app/global/auth/sign_in.dart';
import 'package:useful_useless_app/ui/custometabbar.dart';
import 'package:url_launcher/url_launcher.dart';


class LoginPage extends StatelessWidget {
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
              Image (
                image: AssetImage('assets/logo.jpg'),
                height: 150.0
              ),
              SizedBox(height: 50),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0,0,60,0),
                        child: _signInButtonApple(),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(30,0,0,0),
                              child: _signInButtonGoogle()
                          )
                      )
                  ),
                ],

              ),
              SizedBox(height: 50),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CustomeTabBar();
                      },
                    ),
                  );
                },
                child: Text('Anonymous SignIn',
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
                child: Text('Term & Conditions',
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

class _signInButtonApple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        MdiIcons.apple,
        size: 70,
      ),
      onPressed: (){

      },
    );
  }
}
// ignore: camel_case_types
class _signInButtonGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
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
      icon: Icon(
        MdiIcons.googlePlus,
        size: 80,
      ),
    );
  }
  }




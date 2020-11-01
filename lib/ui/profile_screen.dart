import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:useful_useless_app/models/user_model.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

Widget userAvatarPicker() {
  //TODO here need to be firebaser.user.avatar, UserModel().user_name just for example
  if (UserModel().user_name == null) {
    return Icon(Icons.person, color: Colors.white, size: 50);
  } else {
    return Icon(Icons.person, color: Colors.red, size: 50);
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  int regionsNumber = 0;
  //TODO make variable interactive example
  int trackRegionsNumber() {
    return regionsNumber = regionsNumber + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(children: [
        Row(
          children: [
            //TODO it's need to be a TabbarContent?
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        trackRegionsNumber();
                      });
                    },
                    child: Icon(
                      Icons.map,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                  Text(regionsNumber.toString()),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: userAvatarPicker(),
                  ),
                  Text('UserModel().user_name'),
                  //TODO also neded some checker, and what will write in default
                ],
              ),
            ),
            Expanded(
              child: FlatButton(
                  child: Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 50,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  }),
            ),
          ],
        ),
        Divider(
          thickness: 2,
          color: Colors.black,
        ),
      ]),
    );
  }
}

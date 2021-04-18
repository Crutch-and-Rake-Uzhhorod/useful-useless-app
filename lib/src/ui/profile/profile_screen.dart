import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/models/user_model.dart';
import '../settings/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
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
      child: Column(
        children: [
          Row(
            children: [
              //TODO: no set_state allowed with state management
              //TODO it's need to be a TabBar Content?
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            trackRegionsNumber();
                          },
                        );
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
                      child: _userAvatarPicker(),
                    ),
                    Text('UserModel().user_name'),

                    /// '${UserModel().user_name}'
                    //TODO also needed some checker, and what will write in default
                  ],
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                  child: Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _userAvatarPicker() {
    //TODO here need to be firebase.user.avatar, UserModel().user_name just for example
    if (UserModel().user_name == null) {
      return Icon(Icons.person, color: Colors.white, size: 50);
    } else {
      return Icon(Icons.person, color: Colors.red, size: 50);
    }
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/models/user_model.dart';
import '../global/localization/language_view.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool SwitchState = true;
  //TODO: add Theme.of
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr(),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 20.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
            ),
            child: ListTile(
              title: Text('language'.tr()),
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: (context) => LanguageView());
              },
              trailing: Text('lang_name'.tr()),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
            ),
            child: ListTile(
              title: Text('get_notification'.tr()),
              onTap: () {
                setState(
                  //TODO: no set_state allowed
                  () {
                    SwitchState = !SwitchState;
                  },
                );
              },
              trailing: Switch(
                  value: SwitchState,
                  onChanged: (bool SwitchChange) {
                    setState(
                      () {
                        SwitchState = SwitchChange;
                        UserModel(
                          //TODO I don't know how it's works (for some reason it always gives null)
                          notification_settings: SwitchState,
                        );
                        print(UserModel().notification_settings);
                      },
                    );
                  }),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.black, width: 1, style: BorderStyle.solid),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FlatButton(
        onPressed: () {},
        child: Text(
          'exit'.tr(),
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.black, width: 1, style: BorderStyle.solid),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:useful_useless_app/global/localization/language_view.dart';
import 'package:useful_useless_app/models/user_model.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool SwitchState = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('settings'.tr()),
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
                title: Text('langch'.tr()),
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
                title: Text('Получать уведомления об отключениях'),
                onTap: () {
                  setState(() {
                    SwitchState = !SwitchState;
                  });
                },
                trailing: Switch(
                    value: SwitchState,
                    onChanged: (bool SwitchChange) {
                      setState(() {
                        SwitchState = SwitchChange;
                        UserModel(
                          //TODO I don't know how it's works (for some reason it always gives null)
                          notification_settings: SwitchState,
                        );
                        print(UserModel().notification_settings);
                      });
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
        ));
  }
}

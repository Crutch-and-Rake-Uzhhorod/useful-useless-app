import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_useless_app/src/core/provider/user_provider.dart';
import 'package:useful_useless_app/src/ui/login/login_screen.dart';

import '../../global/localization/language_view.dart';
import '../global/rounded_button_widget.dart';

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
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButtonWidget(
              height: 56.0,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => LanguageView(),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 6.0,
                ),
                child: Row(
                  children: [
                    Text('language'.tr()),
                    const Spacer(),
                    Text('lang_name'.tr()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            RoundedButtonWidget(
              height: 56.0,
              onTap: () {
                setState(
                  () {
                    SwitchState = !SwitchState;
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 6.0, 14.0, 6.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'get_notification'.tr(),
                        maxLines: 3,
                      ),
                    ),
                    Switch(
                      value: SwitchState,
                      onChanged: (bool SwitchChange) {
                        setState(
                          () {
                            SwitchState = SwitchChange;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48.0),
            TextButton(
              style: ButtonStyle(
                overlayColor:
                    MaterialStateColor.resolveWith((_) => Colors.transparent),
                foregroundColor:
                    MaterialStateColor.resolveWith((_) => Colors.grey),
              ),
              onPressed: () => signOut(context),
              child: Text('Change user'),
            ),
          ],
        ),
      ),
    );
  }

  void signOut(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user != null) {
      userProvider.signOut();
    }
    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.id, (_) => false);
  }
}

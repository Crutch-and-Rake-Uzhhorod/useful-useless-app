import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/settings_provider.dart';
import '../../core/provider/user_auth_provider.dart';
import '../../global/localization/language_view.dart';
import '../global/rounded_button_widget.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = 'settings_screen';

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(
      context,
      listen: false,
    );

    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 4,
            ),
            RoundedButtonWidget(
              height: 70.0,
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
                    Text(
                      'language'.tr(),
                      style: textTheme.bodyText1?.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    Text(
                      'lang_name'.tr(),
                      style: textTheme.bodyText1?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            RoundedButtonWidget(
              height: 70.0,
              onTap: settingsProvider.getNotification,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 6.0, 14.0, 6.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        'get_notification'.tr(),
                        style: textTheme.bodyText1?.copyWith(fontSize: 16),
                      ),
                    ),
                    Consumer<SettingsProvider>(
                      builder: (_, settingsProvider, __) => Switch(
                        value: settingsProvider.switchState,
                        onChanged: (_) => settingsProvider.getNotification(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _descriptionStatusElectricity(
                  text: 'electricity_available'.tr(),
                  context: context,
                  colors: Colors.green,
                ),
                _descriptionStatusElectricity(
                  text: 'electricity_half_available'.tr(),
                  context: context,
                  colors: Colors.yellow,
                ),
                _descriptionStatusElectricity(
                  text: 'electricity_not_available'.tr(),
                  context: context,
                  colors: Colors.red,
                ),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor:
                    MaterialStateColor.resolveWith((_) => Colors.transparent),
                foregroundColor:
                    MaterialStateColor.resolveWith((_) => Colors.grey),
              ),
              onPressed: () => signOut(context),
              child: Text(
                'exit'.tr(),
                style: textTheme.bodyText1
                    ?.copyWith(color: Colors.orange, fontSize: 18),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _descriptionStatusElectricity(
      {required String text,
      required BuildContext context,
      required Color colors}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          height: 14,
          width: 14,
          decoration: BoxDecoration(
            color: colors,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 14,
              ),
        ),
      ],
    );
  }

  void signOut(BuildContext context) {
    final userProvider = Provider.of<UserAuthProvider>(context, listen: false);
    if (userProvider.user != null) {
      userProvider.signOut();
    }
    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.id, (_) => false);
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/settings_provider.dart';
import '../../core/provider/user_provider.dart';
import '../../global/localization/language_view.dart';
import '../../ui/global/rounded_button_widget.dart';
import '../home_web/widgets/sidebar_web_widget.dart';
import '../login_web/login_screen_web.dart';

class SettingsScreenWeb extends StatelessWidget {
  static const String id = 'settings_web_screen';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonHeight = 100.00;
    final width = MediaQuery.of(context).size.width;
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: SidebarWidget(
        isSettings: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 4,
              ),
              RoundedButtonWidget(
                height: buttonHeight,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => LanguageView(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'language'.tr(),
                        style: textTheme.headline5?.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'lang_name'.tr(),
                        style: textTheme.headline5?.copyWith(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              RoundedButtonWidget(
                height: buttonHeight,
                onTap: () {
                  settingsProvider.getNotification();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'get_notification'.tr(),
                        style: textTheme.headline5?.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      Switch(
                        value: settingsProvider.switchState,
                        onChanged: (bool SwitchChange) {
                          settingsProvider.switchState = SwitchChange;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),

              // const SizedBox(height: 48.0),
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
                  style: textTheme.headline5?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void signOut(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user != null) {
      userProvider.signOut();
    }
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreenWeb.id, (_) => false);
  }
}

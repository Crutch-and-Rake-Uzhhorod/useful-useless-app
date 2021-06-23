import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

import 'package:easy_localization/easy_localization.dart';
import '../../../core/provider/user_auth_provider.dart';
import '../../login_web/login_screen_web.dart';
import '../../profile_web/profile_web_screen.dart';
import '../../settings_web/settings_screen_web.dart';
import '../home_screen_web.dart';

class SidebarWidget extends StatelessWidget {
  SidebarWidget({
    required this.child,
    this.isLogin = false,
    this.isHome = false,
    this.isSettings = false,
    this.isProfile = false,
  });

  final Widget child;
  final bool isHome;
  final bool isLogin;
  final bool isSettings;
  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserAuthProvider>(context, listen: false);
    final user = userProvider.user;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: CollapsibleSidebar(
        fitItemsToBottom: true,
        screenPadding: 10,
        backgroundColor: const Color(0xff2B3138),
        selectedIconBox: const Color(0xff2F4047),
        selectedIconColor: const Color(0xffF3F7F7),
        selectedTextColor: const Color(0xffF3F7F7),
        unselectedIconColor: const Color(0xff6A7886),
        unselectedTextColor: const Color(0xffC0C7D0),
        avatarImg: user!.photoURL?.isNotEmpty ?? false ? NetworkImage(user.photoURL!) : null,
        title: !user.isAnonymous ? user.displayName! : 'Anonymous User'.tr(),
        items: [
          CollapsibleItem(
            icon: Icons.login,
            text: user.isAnonymous ? 'Log In'.tr() : 'Sign Out'.tr(),
            onPressed: () async {
              await userProvider.signOut();
              unawaited(
                  Navigator.pushReplacementNamed(context, LoginScreenWeb.id));
            },
            isSelected: isLogin,
          ),
          CollapsibleItem(
            icon: Icons.home,
            text: 'Home'.tr(),
            onPressed: () async {
              await Navigator.pushReplacementNamed(context, HomeScreenWeb.id);
            },
            isSelected: isHome,
          ),
          CollapsibleItem(
            isSelected: isProfile,
            icon: Icons.account_box,
            text: 'Profile'.tr(),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, ProfileWebScreen.id),
          ),
          CollapsibleItem(
            icon: Icons.settings,
            text: 'Settings'.tr(),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, SettingsScreenWeb.id),
            isSelected: isSettings,
          ),
        ],
        body: child,
      ),
    );
  }
}

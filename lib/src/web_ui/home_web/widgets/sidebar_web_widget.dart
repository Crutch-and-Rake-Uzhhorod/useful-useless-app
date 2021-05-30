import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: CollapsibleSidebar(
        fitItemsToBottom: true,
        screenPadding: 10,
        backgroundColor:
            //isDarkMode ? Colors.grey[700] :
            const Color(0xff2B3138),
        selectedIconBox:
            //isDarkMode ? Colors.deepPurple :
            const Color(0xff2F4047),
        selectedIconColor: const Color(0xffF3F7F7),
        selectedTextColor: const Color(0xffF3F7F7),
        unselectedIconColor:
            //isDarkMode ? Colors.white :
            const Color(0xff6A7886),
        unselectedTextColor:
            //isDarkMode ? Colors.lime[800] :
            const Color(0xffC0C7D0),
        // avatarImg: isDarkMode
        //     ? const AssetImage('assets/black_logo.png')
        //     : const AssetImage('assets/white_logo.png'),
        title: 'NOTIFUCK',
        items: [
          CollapsibleItem(
            icon: Icons.login,
            text: 'Log In',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, LoginScreenWeb.id),
            isSelected: isLogin,
          ),
          CollapsibleItem(
            icon: Icons.home,
            text: 'Home',
            onPressed: () async {
              await Navigator.pushReplacementNamed(context, HomeScreenWeb.id);
            },
            isSelected: isHome,
          ),
          CollapsibleItem(
            isSelected: isProfile,
            icon: Icons.account_box,
            text: 'Profile',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, ProfileWebScreen.id),
          ),
          CollapsibleItem(
            icon: Icons.settings,
            text: 'Settings',
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

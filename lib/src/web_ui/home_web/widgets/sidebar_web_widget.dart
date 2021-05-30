import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';

import '../../login_web/login_screen_web.dart';
import '../../settings_web/settings_screen_web.dart';
import '../home_screen_web.dart';

class SidebarWidget extends StatelessWidget {
  SidebarWidget({
    required this.child,
    this.isLogin = false,
    this.isHome = false,
    this.isSettings = false,
  });
  final Widget child;
  final bool isHome;
  final bool isLogin;
  final bool isSettings;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            icon: Icons.home,
            text: 'Home',
            onPressed: () async {
              await Navigator.pushReplacementNamed(context, HomeScreenWeb.id);
            },
            isSelected: isHome,
          ),
          CollapsibleItem(
            isSelected: isLogin,
            icon: Icons.account_circle,
            text: 'Login',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, LoginScreenWeb.id),
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

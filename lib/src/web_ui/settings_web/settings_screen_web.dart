import 'package:flutter/material.dart';
import '../home_web/widgets/sidebar_web_widget.dart';

class SettingsScreenWeb extends StatelessWidget {
  static const String id = 'settings_screen_id';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          SidebarWidget(
            isSettings: true,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

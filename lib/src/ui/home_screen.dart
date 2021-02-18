import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_useless_app/src/core/provider/user_provider.dart';

import 'custom_tab_bar.dart';
import 'loading_screen.dart';
import 'login_screen.dart';

export 'package:easy_localization_loader/src/json_asset_loader.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/'; //TODO: id = 'home_screen'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildLoaderScreen(context),
      ),
    );
  }

  Widget _buildLoaderScreen(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, authResultSnapshot) {
        if (authResultSnapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        switch (auth.authState) {
          case AuthState.UN_AUTHENTICATED:
            return LoginScreen();
          case AuthState.AUTHENTICATED:
            return CustomTabBar();
        }
        return Container();
      },
    );
  }
}

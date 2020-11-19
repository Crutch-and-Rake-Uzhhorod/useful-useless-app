import 'package:flutter/material.dart';

import 'package:useful_useless_app/global/auth/login_page.dart';

import 'package:provider/provider.dart';
export 'package:easy_localization_loader/src/json_asset_loader.dart';
import 'package:useful_useless_app/ui/loading_screen.dart';
import 'package:useful_useless_app/src/core/provider/user_provider.dart';

import 'custometabbar.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/';

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
              //Navigator.pushReplacementNamed(context, LoginPage.id);
              return LoginPage();
            case AuthState.AUTHENTICATED:
              return CustomeTabBar();
          }
          return Container();
        });
  }
}
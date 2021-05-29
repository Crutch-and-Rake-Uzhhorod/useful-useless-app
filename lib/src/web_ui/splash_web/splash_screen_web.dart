import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/power_off_provider.dart';
import '../../core/provider/user_provider.dart';
import '../home_web/home_screen_web.dart';
import '../login_web/login_screen_web.dart';

class SplashScreenWeb extends StatefulWidget {
  static const String id = 'splash_screen_web';
  @override
  _SplashScreenWebState createState() => _SplashScreenWebState();
}

class _SplashScreenWebState extends State<SplashScreenWeb> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initWeb();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> initWeb() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final isLogged = userProvider.isUserLoggedIn();

    // await userProvider.checkIsAppleSignInAvailable();
    Future.delayed(Duration(seconds: 3), () async {
      if (isLogged) {
        final powerOffProvider =
            Provider.of<PowerOffProvider>(context, listen: false);
        await powerOffProvider.init();

        await Navigator.pushReplacementNamed(context, HomeScreenWeb.id);
      } else {
        await Navigator.pushReplacementNamed(context, LoginScreenWeb.id);
      }
    });
  }
}

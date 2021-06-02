import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import '../../core/provider/power_off_provider.dart';
import '../../core/provider/user_auth_provider.dart';
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
    super.initState();
    initWeb();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.white,
      child: Center(
        child: JumpingText(
          'Updating secret data...',
          style: textTheme.bodyText1?.copyWith(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> initWeb() async {
    final userProvider = Provider.of<UserAuthProvider>(context, listen: false);

    final isLogged = userProvider.isUserLoggedIn();
    final powerOffProvider =
        Provider.of<PowerOffProvider>(context, listen: false);

    Future.delayed(Duration(seconds: 3), () async {
      if (isLogged) {
        await powerOffProvider.init();

        unawaited(powerOffProvider.initFullList());
        await Navigator.pushReplacementNamed(context, HomeScreenWeb.id);
      } else {
        await Navigator.pushReplacementNamed(context, LoginScreenWeb.id);
      }
    });
  }
}

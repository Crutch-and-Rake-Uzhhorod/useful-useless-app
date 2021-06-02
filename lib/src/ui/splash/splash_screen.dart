import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

import '../../core/provider/power_off_provider.dart';
import '../../core/provider/user_auth_provider.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';
import 'widgets/custom_animation.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: AnimatedLiquidCustomProgressIndicator(),
      ),
    );
  }

  //TODO: add {animated_text_kit: ^4.2.0} animated <Loading...> text

  Future<void> initAuth() async {
    final userProvider = Provider.of<UserAuthProvider>(context, listen: false);

    final isLogged = userProvider.isUserLoggedIn();

    // await userProvider.checkIsAppleSignInAvailable();
    Future.delayed(Duration(seconds: 3), () async {
      if (isLogged) {
        final powerOffProvider =
            Provider.of<PowerOffProvider>(context, listen: false);
        await powerOffProvider.init();
        unawaited(powerOffProvider.initFullList());

        await Navigator.pushReplacementNamed(context, HomeScreen.id);
      } else {
        await Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    });
  }
}

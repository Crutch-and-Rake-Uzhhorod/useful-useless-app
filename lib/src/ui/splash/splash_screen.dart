import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_useless_app/src/core/provider/power_off_provider.dart';

import '../../core/provider/user_provider.dart';
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

  Future<void> initAuth() async {
    final auth = Provider.of<UserProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final powerOffProvider =
        Provider.of<PowerOffProvider>(context, listen: false);
    final isLogged = await auth.tryAutoLogin();

    await powerOffProvider.init();
    await userProvider.checkIsAppleSignInAvailable();
    Future.delayed(Duration(seconds: 3), () {
      if (isLogged) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    });
  }
}

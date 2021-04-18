import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    initAuth(context: context);
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

  Future<void> initAuth({required BuildContext context}) async {
    final auth = Provider.of<UserProvider>(context, listen: false);
    final isLogged = await auth.tryAutoLogin();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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

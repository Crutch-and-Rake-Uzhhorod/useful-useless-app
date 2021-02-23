import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/user_provider.dart';
import '../home_screen.dart';
import '../login_screen.dart';
import 'widgets/custom_animation.dart';

export 'package:easy_localization_loader/src/json_asset_loader.dart';

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

  Future<void> initAuth({BuildContext context}) async {
    final auth = Provider.of<UserProvider>(context, listen: false);
    final isLogged = await auth.tryAutoLogin();
    if (isLogged) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      });
    }
  }
}

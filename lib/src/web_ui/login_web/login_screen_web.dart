import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/provider/power_off_provider.dart';
import '../../core/provider/user_provider.dart';
import '../../ui/global/loader_widget.dart';
import '../../ui/global/rounded_button_widget.dart';
import '../home_web/home_screen_web.dart';

class LoginScreenWeb extends StatelessWidget {
  static const String id = 'login_screen_web';

  final Key _key = Key('web_loader_key');
  @override
  Widget build(BuildContext context) {
    final powerOffProvider = Provider.of<PowerOffProvider>(
      context,
      listen: false,
    );
    final size = MediaQuery.of(context).size;
    return ValueListenableBuilder<bool>(
      valueListenable: powerOffProvider.loadingStatus,
      builder: (_, isLoading, child) {
        return Stack(
          children: [
            child!,
            if (isLoading)
              AbsorbPointer(
                child: LoaderWidget(
                  key: _key,
                ),
              ),
          ],
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xff2F4047).withOpacity(0.1),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: Offset(0, 9),
                  blurRadius: 20,
                  spreadRadius: 0.1,
                ),
              ],
            ),
            height: size.height / 1.5,
            width: size.width / 2,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Spacer(
                //   flex: 3,
                // ),
                Image(
                  image: AssetImage('assets/logo.jpg'),
                  height: 200.0,
                ),
                Spacer(
                  flex: 1,
                ),
                // Column(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //
                //   ],
                // ),
                RoundedButtonWidget(
                  onTap: () {
                    _signInAnonymously(context);
                  },
                  child: Text(
                    'Anonymous Sign In',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 20,
                        ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                RoundedButtonWidget(
                  onTap: () => _signInWithGoogle(context),
                  child: SvgPicture.asset(
                    'assets/icons/google.svg',
                    height: 50,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                TextButton(
                  onPressed: () async => await _termsConditionsLink(),
                  child: Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _termsConditionsLink() async {
    const url = 'https://github.com/Crutch-and-Rake-Uzhhorod/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    final powerOffProvider = Provider.of<PowerOffProvider>(
      context,
      listen: false,
    );

    //probably move somewhere
    powerOffProvider.loadingStatus.value = true;

    await userProvider.signInWithGoogle().then(
      (user) async {
        if (user != null) {
          await powerOffProvider.init();

          await Navigator.pushReplacementNamed(
            context,
            HomeScreenWeb.id,
          );
        } else {
          powerOffProvider.loadingStatus.value = false;
        }
      },
      onError: (_) {
        powerOffProvider.loadingStatus.value = false;

        log('Aborted sign in with google');
      },
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    final powerOffProvider = Provider.of<PowerOffProvider>(
      context,
      listen: false,
    );

    //probably move somewhere
    powerOffProvider.loadingStatus.value = true;

    await userProvider.signInAnonymously().then(
      (user) async {
        if (user != null) {
          await powerOffProvider.init();

          await Navigator.pushReplacementNamed(
            context,
            HomeScreenWeb.id,
          );
        } else {
          powerOffProvider.loadingStatus.value = false;
        }
      },
      onError: (_) {
        powerOffProvider.loadingStatus.value = false;

        log('Error while signing in anonymous');
      },
    );
  }
}

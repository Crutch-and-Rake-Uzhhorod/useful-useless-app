import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/provider/power_off_provider.dart';
import '../../core/provider/user_provider.dart';
import '../global/loader_widget.dart';
import '../global/rounded_button_widget.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  bool get _isIOS => defaultTargetPlatform == TargetPlatform.iOS;
  final Key _key = Key('mobile_loader_key');
  @override
  Widget build(BuildContext context) {
    final powerOffProvider = Provider.of<PowerOffProvider>(
      context,
      listen: false,
    );

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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Spacer(
                  flex: 4,
                ),
                Image(
                  image: AssetImage('assets/logo.jpg'),
                  height: 150.0,
                ),
                Spacer(
                  flex: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: RoundedButtonWidget(
                        onTap: () {
                          if (_isIOS) {
                            ///for iOS
                          } else {
                            _signInAnonymously(context);
                          }
                        },
                        child: _isIOS
                            ? SvgPicture.asset(
                                'assets/icons/apple.svg',
                                height: 50,
                              )
                            : Text(
                                'Anonymous\nSign In',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: RoundedButtonWidget(
                        onTap: () => _signInWithGoogle(context),
                        child: SvgPicture.asset(
                          'assets/icons/google.svg',
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                if (_isIOS)
                  RoundedButtonWidget(
                    onTap: () => Navigator.pushNamed(context, HomeScreen.id),
                    child: Text(
                      'Anonymous Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 24, color: Colors.black),
                    ),
                  ),
                Spacer(
                  flex: _isIOS ? 2 : 4,
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
          unawaited(powerOffProvider.initFullList());

          await Navigator.pushReplacementNamed(
            context,
            HomeScreen.id,
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
          unawaited(powerOffProvider.initFullList());

          await Navigator.pushReplacementNamed(
            context,
            HomeScreen.id,
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

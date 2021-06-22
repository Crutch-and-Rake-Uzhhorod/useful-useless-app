import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/provider/user_auth_provider.dart';
import '../../ui/global/rounded_button_widget.dart';
import '../home_web/widgets/sidebar_web_widget.dart';

class ProfileWebScreen extends StatelessWidget {
  static const String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    final buttonHeight = 100.00;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SidebarWidget(
        isProfile: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 96.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              _getUserAvatar(context),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  _getUserName(context),
                  textAlign: TextAlign.center,
                  style: textTheme.headline5,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              RoundedButtonWidget(
                height: buttonHeight,
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 6.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.map,
                        size: 50,
                        color: Colors.black38,
                      ),
                      Text(
                        '${'followed_locations'.tr()} (1)',
                        style: textTheme.headline5?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // RoundedButtonWidget(
              //   height: buttonHeight,
              //   onTap: () {
              //     Navigator.pushNamed(context, SettingsScreenWeb.id);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 24.0,
              //       vertical: 6.0,
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Icon(
              //           Icons.settings,
              //           size: 50,
              //           color: Colors.black38,
              //         ),
              //         //  const SizedBox(width: 32.0),
              //         Text(
              //           'settings'.tr(),
              //           style: textTheme.headline5?.copyWith(
              //             fontSize: 24,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         const SizedBox(),
              //       ],
              //     ),
              //   ),
              // ),
              const Spacer(),
              RoundedButtonWidget(
                height: buttonHeight,
                onTap: () async => await _termsConditionsLink(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 6.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.info,
                        size: 50,
                        color: Colors.black38,
                      ),
                      //  const SizedBox(width: 32.0),
                      Text(
                        'Terms & conditions',
                        style: textTheme.headline5?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
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

  Widget _getUserAvatar(BuildContext context) {
    final userProvider = Provider.of<UserAuthProvider>(context, listen: false);
    final user = userProvider.user;
    final hasPhoto = !(user?.isAnonymous ?? true) && user?.photoURL != null;

    return Container(
      height: 96.0,
      width: 96.0,
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black12),
        color: Colors.white,
        image: hasPhoto
            ? DecorationImage(image: NetworkImage(user!.photoURL!))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(0, 9),
            blurRadius: 20,
            spreadRadius: 0.1,
          ),
        ],
      ),
      child: !hasPhoto
          ? Icon(
              Icons.person,
              size: 72.0,
            )
          : null,
    );
  }

  String _getUserName(BuildContext context) {
    final userProvider = Provider.of<UserAuthProvider>(context, listen: false);
    final user = userProvider.user;
    if (!(user?.isAnonymous ?? true) &&
        (user?.displayName?.isNotEmpty ?? false)) {
      return user!.displayName!;
    } else {
      return 'Anonymous User';
    }
  }
}

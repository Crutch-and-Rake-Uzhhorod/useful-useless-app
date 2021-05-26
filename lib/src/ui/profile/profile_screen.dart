import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/user_provider.dart';
import '../global/rounded_button_widget.dart';
import '../settings/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(width * 0.07, 56.0, width * 0.07, 42.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getUserAvatar(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              _getUserName(context),
              textAlign: TextAlign.center,
              style: textTheme.headline5,
            ),
          ),
          RoundedButtonWidget(
            height: 56.0,
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 6.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.map,
                    color: Colors.black38,
                  ),
                  const SizedBox(width: 16.0),
                  Text('${'followed_locations'.tr()} (1)'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          RoundedButtonWidget(
            height: 56.0,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 6.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.black38,
                  ),
                  const SizedBox(width: 16.0),
                  Text('settings'.tr()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          RoundedButtonWidget(
            height: 56.0,
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 6.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.black38,
                  ),
                  const SizedBox(width: 16.0),
                  Text('Terms & conditions'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getUserAvatar(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final hasPhoto = user?.photoURL != null;

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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    if (user?.displayName?.isNotEmpty ?? false) {
      return user!.displayName!;
    } else {
      return 'Anonymous User';
    }
  }
}

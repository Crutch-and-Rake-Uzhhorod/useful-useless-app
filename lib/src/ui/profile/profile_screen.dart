import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/profile_provider.dart';
import '../../core/provider/user_auth_provider.dart';
import '../global/rounded_button_widget.dart';
import 'widgets/autocomplete_widget.dart';
import 'widgets/dropDownButton_widget.dart';

class ProfileScreen extends StatelessWidget {
  static const String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.07, 32.0, width * 0.07, 42.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getUserAvatar(context),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8,
            ),
            child: Text(
              _getUserName(context),
              textAlign: TextAlign.center,
              style: textTheme.headline5,
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 75,
            child: Row(
              children: [
                Consumer<ProfileProvider>(
                  builder: (_, profileProvider, __) {
                    return DropDownButtonWidget(
                      items: profileProvider.area,
                      value: profileProvider.areaItem,
                      hintText: 'Місто',
                      onChanged: (newValue) {
                        if (newValue != null) {
                          profileProvider.updateAreaItem(newItem: newValue);
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  width: 16,
                ),
                Flexible(
                  child: Consumer<ProfileProvider>(
                    builder: (_, profileProvider, __) {
                      return AutocompleteWidget(
                        hintText: 'Обласний район',
                        options: profileProvider.listOfChosenRegions,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Flexible(
            child: Consumer<ProfileProvider>(
              builder: (_, profileProvider, __) {
                return AutocompleteWidget(
                  hintText: 'Місто',
                  options: profileProvider.listOfChosenCities,
                );
              },
            ),
          ),
          const SizedBox(
            height: 32,
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
                  Text(
                    '${'followed_locations'.tr()} (1)',
                    style: textTheme.bodyText1
                        ?.copyWith(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 40, left: 16),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return _descriptionStatusElectricity(
                  text: 'Львів',
                  colors: Colors.yellow,
                  context: context,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionStatusElectricity(
      {required String text,
      required BuildContext context,
      required Color colors}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: colors,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 16,
              ),
        ),
      ],
    );
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../global/localization/language_view.dart';

//TODO: why stateful?
class SharedPref extends StatefulWidget {
  @override
  _SharedPrefState createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.blue,
            ),
            title: Text('language'.tr()),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => LanguageView(),
              );
            },
          )
        ],
      ),
    );
  }
}

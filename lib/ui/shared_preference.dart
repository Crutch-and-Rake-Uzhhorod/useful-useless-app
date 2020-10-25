import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:useful_useless_app/global/localization/language_view.dart';

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
              title: Text('langch'.tr()),
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: (context) => LanguageView());
              },
            )
          ],
        ));
  }
}

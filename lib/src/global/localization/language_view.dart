import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyState();
}

class MyState extends State<LanguageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff737373),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 26),
              margin: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'title'.tr(),
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            RadioListTile<Locale>(
                value: context.supportedLocales[1],
                groupValue: context.locale,
                title: Text('lang'.tr(args: ['Українська'])),
                onChanged: (Locale locale) {
                  setState(() {
                    context.setLocale(locale);
                  });
                }),
            RadioListTile<Locale>(
                value: context.supportedLocales[0],
                groupValue: context.locale,
                title: Text('lang'.tr(args: ['Русский'])),
                onChanged: (Locale locale) {
                  setState(() {
                    context.setLocale(locale);
                  });
                }),
          ],
        ),
      ),
    );
  }
}

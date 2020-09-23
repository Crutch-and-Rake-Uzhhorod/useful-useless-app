import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:developer';


enum LanguageChoice { uk, ru }

class LanguageView extends StatefulWidget {
  const LanguageView ({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState()=> MyState();
}

class MyState extends State<LanguageView > {

  @override
  Widget build(BuildContext context) {
    var _lang = context.locale;

    locale: EasyLocalization.of(context).supportedLocales[0];
    return Container(
        color: Color(
            0xff737373) ,
        child: Container(
            height: 200 ,
            decoration: BoxDecoration(
              color: Colors.white ,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    10) ,
                topRight: Radius.circular(
                    10) ,
              ) ,
            ) ,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 26) ,
                    margin: EdgeInsets.symmetric(
                      horizontal: 24 ,
                    ) ,
                    child: Text(
                      'title'.tr(
                      ) ,
                      style: TextStyle(
                        color: Colors.blue ,
                        fontFamily: 'Montserrat' ,
                        fontWeight: FontWeight.w700 ,
                        fontSize: 18 ,
                      ) ,
                    ) ,
                  ) ,

                  RadioListTile<LanguageChoice>(
                      value: LanguageChoice.uk ,
                      groupValue: _lang ,
                      title: Text(
                          'lang'.tr(
                              args: ['Українська'])) ,

                      onChanged: (LanguageChoice locale) {
                        locale: context.supportedLocales[1];
                        setState(
                                () {
                              _lang = locale as Locale;

                            });
                      }) ,
                  RadioListTile<LanguageChoice>(
                      value: LanguageChoice.ru ,
                      groupValue: _lang ,
                      title: Text(
                          'lang'.tr(
                              args: ['Русский'])) ,
                      onChanged: (LanguageChoice locale) {
                        locale: EasyLocalization.of(context).supportedLocales[0];
                        setState(
                                () {
                              _lang = locale as Locale;
                            });
                      }) ,
                ])));
  }

}




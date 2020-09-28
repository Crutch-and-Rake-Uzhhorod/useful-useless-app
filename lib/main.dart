import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:useful_useless_app/global/auth/login_page.dart';




export 'package:easy_localization_loader/src/json_asset_loader.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [
      Locale('ru', 'RU'),
      Locale('uk', 'UA'),
    ],
    path: 'lang',
    startLocale: Locale('uk', 'UA'),
    saveLocale: true,
    useOnlyLangCode: true,
  ));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), //CustomeTabBar(),
    );
  }
}

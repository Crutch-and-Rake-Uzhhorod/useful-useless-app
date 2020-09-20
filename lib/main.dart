import 'package:flutter/material.dart';
import 'custometabbar.dart';
import 'package:easy_localization/easy_localization.dart';
export 'package:easy_localization_loader/src/json_asset_loader.dart';
import 'localization/codegen_loder.dart';

void main() {
  runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale('ru', 'RU'),
        Locale('ua', 'UA'),
      ],
      path: 'assets/lang',
      fallbackLocale: Locale('ua', 'UA'),
      startLocale: Locale('ua', 'UA'),
      saveLocale: true,
//      assetLoader: JsonAssetLoader()));
  assetLoader: CodegenLoader()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomeTabBar(),
    );
  }
}

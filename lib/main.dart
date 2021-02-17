import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/core/provider/power_off_provider.dart';
import 'src/core/provider/user_provider.dart';
import 'src/ui/home_screen.dart';
import 'src/ui/login_screen.dart';

export 'package:easy_localization_loader/src/json_asset_loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PowerOffProvider(),
        ),
      ],
      child: EasyLocalization(
        child: Consumer<UserProvider>(
          builder: (context, UserProvider userProvider, _) {
            return MyApp();
          },
        ),
        supportedLocales: [
          Locale('ru', 'RU'),
          Locale('uk', 'UA'),
        ],
        path: 'lang',
        startLocale: Locale('uk', 'UA'),
        saveLocale: true,
        useOnlyLangCode: true,
      ),
    ),
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
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
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },
    );
  }
}

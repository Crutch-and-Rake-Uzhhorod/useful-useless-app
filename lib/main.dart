import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'src/core/provider/power_off_provider.dart';
import 'src/core/provider/settings_provider.dart';
import 'src/core/provider/user_auth_provider.dart';
import 'src/core/repository/marker_repository.dart';
import 'src/core/repository/mock_repository.dart';
import 'src/core/repository/user_auth_repository.dart';
import 'src/core/repository/user_data_repository.dart';
import 'src/core/services/firebase_auth_service.dart';
import 'src/core/services/firestore_service.dart';
import 'src/core/services/push_notification_service.dart';
import 'src/ui/home/home_screen.dart';
import 'src/ui/login/login_screen.dart';
import 'src/ui/splash/splash_screen.dart';
import 'src/web_ui/home_web/home_screen_web.dart';
import 'src/web_ui/login_web/login_screen_web.dart';
import 'src/web_ui/profile_web/profile_web_screen.dart';
import 'src/web_ui/settings_web/settings_screen_web.dart';
import 'src/web_ui/splash_web/splash_screen_web.dart';

Future<void> initLocalNotifications() async {
  const _channel = AndroidNotificationChannel(
    'notifuck_notifications', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);
}

Future<void> _onBackgroundMessageHandler(RemoteMessage message) async {
  log('Handling a background message: ${message.messageId}');
  log('Message clicked on terminated!');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  if (!kIsWeb) {
    await initLocalNotifications();
  }
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await MarkerRepository.initMarkerIcons();

  final mockRepository = MockRepository();

  final firestoreService = FirestoreService();

  final firebaseAuthService = FirebaseAuthService(
    firestoreService: firestoreService,
  );

  final userAuthRepository = UserAuthRepository(
    firebaseAuthService: firebaseAuthService,
  );

  final userDataRepository = UserDataRepository(
    firestoreService: firestoreService,
  );

  runApp(
    Multi(
      mockRepository: mockRepository,
      firebaseAuthService: firebaseAuthService,
      firestoreService: firestoreService,
      userAuthRepository: userAuthRepository,
      userDataRepository: userDataRepository,
      child: MyApp(),
    ),
  );
}

class Multi extends StatelessWidget {
  Multi({
    this.child,
    required this.mockRepository,
    required this.firestoreService,
    required this.firebaseAuthService,
    required this.userAuthRepository,
    required this.userDataRepository,
  });

  final Widget? child;
  final MockRepository mockRepository;
  final FirebaseAuthService firebaseAuthService;
  final FirestoreService firestoreService;
  final UserAuthRepository userAuthRepository;
  final UserDataRepository userDataRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuthProvider>(
          create: (_) => UserAuthProvider(
            userAuthRepository: userAuthRepository,
          ),
        ),
        ChangeNotifierProvider<PowerOffProvider>(
          create: (_) => PowerOffProvider(
            firestoreService: firestoreService,
          ),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(
            userAuthRepository: userAuthRepository,
            userDataRepository: userDataRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  static final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics();
  static final FirebaseAnalyticsObserver _firebaseAnalyticsObserver =
      FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    PushNotificationService().initialise();

    return EasyLocalization(
      supportedLocales: [
        Locale('ru', 'RU'),
        Locale('uk', 'UA'),
      ],
      path: 'lang',
      startLocale: Locale('uk', 'UA'),
      saveLocale: true,
      useOnlyLangCode: true,
      child: Consumer<UserAuthProvider>(
        builder: (context, UserAuthProvider userProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorObservers: [_firebaseAnalyticsObserver],
            title: 'Flutter Demo',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: kIsWeb ? SplashScreenWeb.id : SplashScreen.id,
            routes: kIsWeb
                ? {
                    SplashScreenWeb.id: (_) => SplashScreenWeb(),
                    LoginScreenWeb.id: (_) => LoginScreenWeb(),
                    HomeScreenWeb.id: (_) => HomeScreenWeb(),
                    SettingsScreenWeb.id: (_) => SettingsScreenWeb(),
                    ProfileWebScreen.id: (_) => ProfileWebScreen(),
                  }
                : {
                    SplashScreen.id: (_) => SplashScreen(),
                    LoginScreen.id: (_) => LoginScreen(),
                    HomeScreen.id: (_) => HomeScreen(),
                  },
          );
        },
      ),
    );
  }
}

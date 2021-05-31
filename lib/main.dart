import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'src/core/provider/power_off_provider.dart';
import 'src/core/provider/user_provider.dart';
import 'src/core/repository/marker_repository.dart';
import 'src/core/repository/mock_repository.dart';
import 'src/core/repository/user_repository.dart';
import 'src/core/services/firebase_auth_service.dart';
import 'src/core/services/firestore_service.dart';
import 'src/core/services/push_notification_service.dart';
import 'src/ui/home/home_screen.dart';
import 'src/ui/login/login_screen.dart';
import 'src/ui/splash/splash_screen.dart';

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
  await initLocalNotifications();
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

  final userRepository = UserRepository(
    firebaseAuthService: firebaseAuthService,
  );

  runApp(
    Multi(
      mockRepository: mockRepository,
      firebaseAuthService: firebaseAuthService,
      firestoreService: firestoreService,
      userRepository: userRepository,
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
    required this.userRepository,
  });

  final Widget? child;
  final MockRepository mockRepository;
  final FirebaseAuthService firebaseAuthService;
  final FirestoreService firestoreService;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(
            userRepository: userRepository,
          ),
        ),
        ChangeNotifierProvider<PowerOffProvider>(
          create: (_) => PowerOffProvider(
            firestoreService: firestoreService,
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
      child: Consumer<UserProvider>(
        builder: (context, UserProvider userProvider, _) {
          return MaterialApp(
            navigatorObservers: [_firebaseAnalyticsObserver],
            title: 'Flutter Demo',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: SplashScreen.id,
            routes: {
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

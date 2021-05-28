import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class PushNotificationService {
  PushNotificationService();

  Future<void> initialise() async {
    final _settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kIsWeb) {
      await FirebaseMessaging.instance.getToken(
        vapidKey:
            'BGw7X-tMe991KA9o-3lB0U-4Jz5LNcEYq7376rjhGcQUIh2HbLRXJt2fVKAdVZ63R8nLqS1MkMhUMd4hc6F0GUk',
      );
    }
    log('${_settings.authorizationStatus}');
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      log('message received');
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('Message clicked on closed app!');
    });
  }
}

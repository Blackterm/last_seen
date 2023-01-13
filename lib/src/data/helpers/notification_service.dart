import 'package:eventify/eventify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grock/grock.dart';

class NotifService {
  static FirebaseMessaging? messaging;
  static var localNotifService = FlutterLocalNotificationsPlugin();
  static late EventEmitter emitter;

  static void setEmitter(EventEmitter _emitter) {
    emitter = _emitter;
  }

  static EventEmitter getEmitter() {
    return emitter;
  }

  static void settingsNotification() async {
    await messaging!.requestPermission(alert: true, badge: true, sound: true);
  }

  static void connectNotification() async {
    messaging = FirebaseMessaging.instance;
    messaging!.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    settingsNotification();
    FirebaseMessaging.onBackgroundMessage(backgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      event.data['type'] != 'notification'
          ? emitter.emit(
              event.data['type'], "NotificationService", event.data['data'])
          : null;

      Grock.snackBar(
          title: event.notification!.title != null
              ? event.notification!.title!
              : "",
          description:
              event.notification!.body != null ? event.notification!.body! : "",
          leading: event.notification!.android!.imageUrl == null
              ? null
              : Image.network(
                  event.notification!.android!.imageUrl!,
                  width: 64.0,
                  height: 64.0,
                  fit: BoxFit.cover,
                ),
          opacity: 0.5,
          position: SnackbarPosition.top,
          duration: Duration(seconds: 6));
    });

    getToken();
  }

  static getToken() async {
    final String? token = await messaging!.getToken();
    return token;
  }

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    await localNotifService.initialize(settings);
  }

  static showBackNotification(id, title, body, payload) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        playSound: true,
        importance: Importance.max,
        priority: Priority.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await localNotifService.show(id, title, body, notificationDetails);
  }

  static Future<void> backgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // this object of class is responsible for displaying local notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // local notification
  Future<void> initLocalNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    // this setting object contain all platform specification setting
    InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
    );
    // this step intilize the local notification without this it wont work
    flutterLocalNotificationsPlugin.initialize(settings: settings);
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      criticalAlert: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {
    }
  }

  Future<String?> getFcmToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  // local notification show
 void showNotification(RemoteMessage message) {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    channelDescription: 'This channel is used for important notifications.',
    importance: Importance.high,
    priority: Priority.high,
  );

  NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  flutterLocalNotificationsPlugin.show(
    // id:0,
    id:DateTime.now().millisecondsSinceEpoch ~/ 1000,
    title:  message.notification?.title ?? "No Title",
   body:  message.notification?.body ?? "No Body",
    notificationDetails : notificationDetails,
  );
}
}

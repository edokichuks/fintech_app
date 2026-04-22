// Dart imports:
import 'dart:io';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Project imports

class DeviceNotification {
  // 🔐 Private constructor
  DeviceNotification._internal();

  // 📦 Static instance (singleton)
  static final DeviceNotification _instance = DeviceNotification._internal();

  // 🔓 Public factory getter
  static DeviceNotification get instance => _instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String?> getNotificationToken() async {
    // if (Platform.isIOS) {
    //   return await messaging.getAPNSToken();
    // } else {
    return await messaging.getToken();
    // }
  }

  String onTokenRefresh() {
    return "notifyToken";
  }

  Future<bool> requestNotificationPermisions() async {
    if (Platform.isIOS) {
      await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
    }

    NotificationSettings notificationSettings =
        await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    return notificationSettings.authorizationStatus ==
            AuthorizationStatus.authorized ||
        notificationSettings.authorizationStatus ==
            AuthorizationStatus.provisional;
  }

  // For iOS
  Future<void> initForgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _initLocalNotifications() async {
    var androidInitSettings =
        const AndroidInitializationSettings('notification_icon');
    var iosInitSettings = const DarwinInitializationSettings();

    var initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (payload) {
        // handleMesssage(onMessageReceived: onMessageReceived)
      },
    );
  }

  void firebaseInit() {
    _initLocalNotifications();
    // setupInteractMessage();

    FirebaseMessaging.onMessage.listen((message) {
      // print("rooor ${message.data}");
      initForgroundMessage();

      showForegroundNotification(message);
    });
  }

  Future<void> handleMesssage(
      {required Function(RemoteMessage, bool?) onMessageReceived}) async {
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    // debugLog('TEST DATA FROM PUSH ${message.data.toString()}');
    if (initialMessage != null) {
      await onMessageReceived(initialMessage, true);
    }

    FirebaseMessaging.onBackgroundMessage(
      (message) async {
        await onMessageReceived(message, false);
      },
    );

    FirebaseMessaging.onMessage.listen((message) async {
      // await showForegroundNotification(message);
      await onMessageReceived(message, true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      await onMessageReceived(message, false);
    });
  }

  // Future<void> setupInteractMessage() async {
  //   // when app is terminated
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();

  //   if (initialMessage != null) {
  //     handleMesssage(
  //       onMessageReceived: (p0, p1) {},
  //     );
  //   }

  //   //when app ins background
  //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //     // handleMesssage(event);
  //   });
  // }

  Future<void> showForegroundNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      androidNotificationChannel.id.toString(),
      androidNotificationChannel.name.toString(),
      channelDescription: 'ditchride_rider_channel',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      sound: androidNotificationChannel.sound,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    // int uniqueNotificationId = Uuid().v4().hashCode.abs();
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        message.hashCode.abs(),
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}

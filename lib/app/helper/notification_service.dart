import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  // instance of FlutterLocalNotificationPlugin

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // initialize

  Future initialize() async {
    //FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("image1");

    const IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false);

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

// simple notification
  showSimpleNotification(int id, String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
        'main_channel', 'main_channel',
        priority: Priority.high, importance: Importance.max);
    const iOSDetails = IOSNotificationDetails();
    const platformDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );
  }

  Future<void> showProgressNotification(int id, String title, String body,
      int maxProgress, int currentProgress) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('main_channel', 'main_channel',
            channelShowBadge: false,
            importance: Importance.max,
            priority: Priority.high,
            onlyAlertOnce: true,
            showProgress: true,
            maxProgress: maxProgress,
            progress: currentProgress);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails, iOS: null);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails);
  }

  

  /*Future<void> showNotification(
      int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', 'main_channel'),
        iOS: IOSNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true),
      ),
    );
  }*/

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

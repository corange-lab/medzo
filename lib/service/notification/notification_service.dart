import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' show Random;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medzo/service/notification/notification_bloc.dart';

class NotificationService {
  final _random = Random();

  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;
  bool _started = false;
  final List<Function> _onMessageCallbacks = [];
  String? _deviceToken;

  String? get deviceToken => _deviceToken;

  // ********************************************************* //
  // YOU HAVE TO CALL THIS FROM SOMEWHERE (May be main widget)
  // ********************************************************* //
  void start() {
    if (!_started) {
      _integrateNotification();
      _refreshToken();
      _started = true;
    }
  }

  void _integrateNotification() {
    _registerNotification();
    _initializeLocalNotification();
  }

  Future<void> _registerNotification() async {
    _firebaseMessaging.requestPermission();
    // _firebaseMessaging.configure(
    //   onMessage: _onMessage,
    //   onLaunch: _onLaunch,
    //   onResume: _onResume,
    // );
    // //
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
      Map<String, dynamic> msg = {
        'data': message.data,
      };
      _performActionOnNotification(msg);
    });
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      if (message.notification != null) {
        log(
            'Message also contained a notification: ${message.notification}');
        if (Platform.isAndroid) {
          _showNotification(message);
        }

        // dispose();
      }
    });

    _firebaseMessaging.onTokenRefresh
        .listen(_tokenRefresh, onError: _tokenRefreshFailure);
  }

  void _showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'Medzo',
      'Chat Notification',
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    //log("message.bodyLocArgs = ${message.bodyLocArgs}");
    await _flutterLocalNotificationsPlugin.show(
      _random.nextInt(1000000),
      message.notification?.title ?? "Medzo",
      message.notification?.body ?? "you have new notification",
      platformChannelSpecifics,
      payload: json.encode(
        message.data,
      ),
    );
  }

  void _initializeLocalNotification() {
    AndroidInitializationSettings androidInitializationSettings =
        // AndroidInitializationSettings('@mipmap/ic_launcher');
        const AndroidInitializationSettings('@mipmap/ic_launcher_round');

    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings();
    _flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings,
      )
    );
  }

  void _refreshToken() {
    Future.delayed(const Duration(milliseconds: 900)).then((value) {
      _firebaseMessaging.getToken().then((token) async {
        log('token: $token');
        _deviceToken = token;
        NotificationsBloc.instance.updateCurrentUserToken(token);
      }, onError: _tokenRefreshFailure);
    });
  }

  void _tokenRefresh(String newToken) async {
    log('New Token : $newToken');
    _deviceToken = newToken;
    NotificationsBloc.instance.updateCurrentUserToken(newToken);
  }

  void _tokenRefreshFailure(error) {
    log("FCM token refresh failed with error $error");
  }

  void _performActionOnNotification(Map<String, dynamic> message) {
    NotificationsBloc.instance.newNotification(message);
  }

  void addOnMessageCallback(Function callback) {
    _onMessageCallbacks.add(callback);
  }

  void removeOnMessageCallback(Function callback) {
    _onMessageCallbacks.remove(callback);
  }

  Future<String?> getPayloadDetails() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      return notificationAppLaunchDetails?.notificationResponse?.payload;
    }
    return null;
  }
}

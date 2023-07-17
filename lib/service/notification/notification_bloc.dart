import 'dart:async';

import 'package:get/get.dart';
import 'package:medzo/api/auth_api.dart';
import 'package:medzo/controller/auth_controller.dart';

class NotificationsBloc {
  bool _sendBufferedEvents = true;
  Map<String, dynamic>? _bufferedEvent;
  AuthApi authApi = AuthApi.instance;

  AuthController authController = Get.put(AuthController());

  NotificationsBloc._internal() {
    _notificationStreamController.onListen = _onListen;
  }

  static final NotificationsBloc instance = NotificationsBloc._internal();

  Stream<Map<String, dynamic>?> get notificationStream =>
      _notificationStreamController.stream;
  final _notificationStreamController =
      StreamController<Map<String, dynamic>?>.broadcast();

  /// Called when `_notificationStreamController` gets first subscriber.
  ///
  /// We need to do this for onLaunch Notification.
  ///
  /// When we click the notification (when app is completely closed) `_notificationStreamController` will add event before it gets any subscriber.
  ///
  /// So we will cache the event before it gets first subscriber.
  ///
  /// In other scenario `_notificationStreamController` will have atleast one subscriber.
  _onListen() {
    if (_sendBufferedEvents) {
      if (_bufferedEvent != null) {
        _notificationStreamController.sink.add(_bufferedEvent);
      }
      _sendBufferedEvents = false;
    }
  }

  void newNotification(Map<String, dynamic> notification) {
    if (_sendBufferedEvents) {
      _bufferedEvent = notification;
    } else {
      _notificationStreamController.sink.add(notification);
    }
  }

  void dispose() {
    _notificationStreamController.close();
  }

  void updateCurrentUserToken(String? newToken) async {
    if (!authController.isLoggedIn()) {
      return;
    }
    // final currentUser = await UserRepository.getInstance()
    //     .getUserById(authController.currentUserId());
    final currentUser = await authApi.getUserDetails(
        userId: authController.currentUserId()!, isLogin: true);
    if (currentUser != null && currentUser.fcmToken != newToken) {
      // UserRepository.getInstance()
      //     .updateUser(currentUser.copyWith(fcmToken: newToken));
      authApi.updateUserDetails(
          userId: currentUser.id!, params: {'fcmToken': newToken});
    }
  }
}

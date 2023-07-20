import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class OnlineUserRepository {
  OnlineUserRepository._();
  static final OnlineUserRepository _instance = OnlineUserRepository._();
  static OnlineUserRepository getInstance() => _instance;

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<void> updateUserPresence(
    String userId,
    bool status,
  ) async {
    await changStatus(userId, status);
    disconnectUserPresence(userId, status);
  }

  void disconnectUserPresence(
    String userId,
    bool status,
  ) {
    Map<String, Object> presenceStatusFalse = {
      'presence': status,
      'last_seen': DateTime.now().microsecondsSinceEpoch,
      'userId': userId
    };
    _databaseReference.child(userId).onDisconnect().update(presenceStatusFalse);
  }

  Future<void> changStatus(
    String userId,
    bool status,
  ) async {
    Map<String, Object> presenceStatusTrue = {
      'presence': status,
      'last_seen': DateTime.now().microsecondsSinceEpoch,
      'userId': userId
    };

    await _databaseReference
        .child(userId)
        .update(presenceStatusTrue)
        .whenComplete(() => print('Updated your presence.'))
        .catchError((e) => print(e));
  }

  Stream<Map<String, dynamic>> showUserPresence(String uid) {
    return _databaseReference.child(uid).onValue.map((event) {
      return Map<String, dynamic>.from(event.snapshot.value as Map);
    });
  }
}

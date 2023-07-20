import 'package:firebase_auth/firebase_auth.dart';
import 'package:medzo/chat/repository/user_online_repository.dart';

class OnlineUserBlock {
  dynamic updateUserPresence(bool status) {
    if (FirebaseAuth.instance.currentUser?.uid == null) return;
    return OnlineUserRepository.getInstance()
        .updateUserPresence(FirebaseAuth.instance.currentUser!.uid, status);
  }

  Future<void> changStatus(
    bool status,
  ) async {
    if (FirebaseAuth.instance.currentUser?.uid == null) return;
    return OnlineUserRepository.getInstance()
        .changStatus(FirebaseAuth.instance.currentUser!.uid, status);
  }

  Stream<Map<String, dynamic>> showUserPresence(String uid) {
    return OnlineUserRepository.getInstance().showUserPresence(uid);
  }
}

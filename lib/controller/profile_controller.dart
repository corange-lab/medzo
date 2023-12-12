import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/model/post_model.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/model/user_relationship.dart';
import 'package:medzo/utils/utils.dart';

class ProfileController extends GetxController {
  final String? uId;

  ProfileController(this.uId);

  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  AllUserController allUserController = Get.find<AllUserController>();

  // fetch the UserModel value from dataSnapShot
  Rx<UserModel> get user => _user;
  Rx<UserModel> _user = UserModel.newUser().obs;

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference blockedUserRef =
      FirebaseFirestore.instance.collection('blocked_users');

  RxBool isBlocked = false.obs;

  Stream<QuerySnapshot>? dataSnapShot;
  late final Stream<List<UserRelationship>> followersStream;
  late final Stream<List<UserRelationship>> followingStream;
  late final Stream<bool> isFollowingStream;

  @override
  void onInit() {
    String uId = this.uId ?? FirebaseAuth.instance.currentUser!.uid;
    dataSnapShot = FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: uId)
        .snapshots();

    super.onInit();

    followersStream = streamFollowers(uId);
    followingStream = streamFollowing(uId);
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    isFollowingStream = streamIsFollowing(currentUserId, uId);

    dataSnapShot!.listen((event) {
      _user.value = UserModel.fromDocumentSnapshot(event.docs.first);
      nameController.text = _user.value.name ?? '';
      professionController.text = _user.value.profession ?? '';
      update();
    });
  }

  Stream<List<UserRelationship>> streamFollowers(String userId) {
    final followersRef = FirebaseFirestore.instance
        .collection('followers')
        .doc(userId)
        .collection('user_followers');
    return followersRef.snapshots().map((followersSnapshot) {
      return parseFollowers(followersSnapshot);
    });
  }

  Stream<List<UserRelationship>> streamFollowing(String userId) {
    final followingRef = FirebaseFirestore.instance
        .collection('followers')
        .doc(userId)
        .collection('user_following');
    return followingRef.snapshots().map((followingSnapshot) {
      return parseFollowing(followingSnapshot);
    });
  }

  Stream<bool> streamIsFollowing(String currentUserId, String targetUserId) {
    final userFollowingRef = FirebaseFirestore.instance
        .collection('followers')
        .doc(currentUserId)
        .collection('user_following');
    return userFollowingRef.doc(targetUserId).snapshots().map((snapshot) {
      return snapshot.exists;
    });
  }

  Future<void> followUser(String targetUserId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final userFollowingRef = FirebaseFirestore.instance
        .collection('followers')
        .doc(currentUserId)
        .collection('user_following');
    final targetFollowerRef = FirebaseFirestore.instance
        .collection('followers')
        .doc(targetUserId)
        .collection('user_followers');

    await userFollowingRef.doc(targetUserId).set({
      'timestamp': FieldValue.serverTimestamp(),
    });

    await targetFollowerRef.doc(currentUserId).set({
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> unfollowUser(String targetUserId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final userFollowingRef = FirebaseFirestore.instance
        .collection('followers')
        .doc(currentUserId)
        .collection('user_following');
    final targetFollowerRef = FirebaseFirestore.instance
        .collection('followers')
        .doc(targetUserId)
        .collection('user_followers');

    await userFollowingRef.doc(targetUserId).delete();
    await targetFollowerRef.doc(currentUserId).delete();
  }

  List<UserRelationship> parseFollowers(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return UserRelationship(
        userId: doc.id,
        timestamp: data['timestamp'].toDate(),
      );
    }).toList();
  }

  List<UserRelationship> parseFollowing(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return UserRelationship(
        userId: doc.id,
        timestamp: data['timestamp'].toDate(),
      );
    }).toList();
  }

  // Stream<List<PostData>> getPosts()

  Stream<List<PostData>> getPosts() {
    var data = FirebaseFirestore.instance
        .collection('posts')
        .where('creatorId', isEqualTo: uId)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return PostData.fromMap(e.data());
      }).toList();
    });
    print('${data.length}');
    return data;
  }

  Future<void> reportOtherUser(
      {required String targetUserId,
      required String reporterId,
      required String reason}) async {
    try {
      final reportsRef = FirebaseFirestore.instance.collection('reports');
      await reportsRef.add({
        'targetUserId': targetUserId,
        'reporterId': reporterId,
        'reason': reason,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Report submitted successfully');
    } catch (e) {
      print('Error submitting report: $e');
    }
  }

  Future<void> blockUser(String myUserId, String blockedUserId) async {
    try {
      DocumentReference myUserDoc = blockedUserRef.doc(myUserId);

      DocumentSnapshot myUserSnapshot = await myUserDoc.get();

      // Check if the document exists
      if (myUserSnapshot.exists) {
        Map<String, dynamic> userData =
            myUserSnapshot.data() as Map<String, dynamic> ?? {};

        List<String> blockedUserIds =
            List<String>.from(userData['userIds'] as List<dynamic> ?? []);

        // Check if the user is already blocked to avoid duplicates
        if (!blockedUserIds.contains(blockedUserId)) {
          blockedUserIds.add(blockedUserId);

          await myUserDoc.set({'userIds': blockedUserIds}).then((value) {
            showInSnackBar("User Blocked!", isSuccess: false, title: "Medzo");
          });
        }
      } else {
        // If the document doesn't exist, create it and set the blocked user ID
        await myUserDoc.set({
          'userIds': [blockedUserId]
        }).then((value) {
          showInSnackBar("User Blocked!", isSuccess: false, title: "Medzo");
        });
      }
    } catch (e) {
      print('Error blocking user: $e');
    }
  }

  Future<void> unblockUser(String myUserId, String blockedUserId) async {
    try {
      DocumentReference myUserDoc = blockedUserRef.doc(myUserId);

      DocumentSnapshot myUserSnapshot = await myUserDoc.get();
      List<String> blockedUserIds = List.from(myUserSnapshot['userIds'] ?? []);

      blockedUserIds.remove(blockedUserId);

      await myUserDoc.set({'userIds': blockedUserIds}).then((value) {
        showInSnackBar("User Unblocked!", isSuccess: false, title: "Medzo");
      });
    } catch (e) {
      print('Error unblocking user: $e');
    }
  }

  Future<bool> isUserBlocked(String myUserId, String blockedUserId) async {
    final DocumentSnapshot blockedUserDoc = await FirebaseFirestore.instance
        .collection('blocked_users')
        .doc(myUserId)
        .get();

    if (blockedUserDoc.exists &&
        blockedUserDoc.data() is Map<String, dynamic>) {
      Map<String, dynamic> data = blockedUserDoc.data() as Map<String, dynamic>;
      List<dynamic> blockedUserIds = data['userIds'];
      return blockedUserIds.contains(blockedUserId);
    }
    return false;
  }

  void checkIfUserIsBlocked(String currentUserId, String otherUserId) async {
    bool isBlocked = await isUserBlocked(currentUserId, otherUserId);
    this.isBlocked.value = isBlocked;
  }

  void toggleBlockUser(String currentUserId, String otherUserId) async {
    if (isBlocked.value) {
      await unblockUser(currentUserId, otherUserId);
    } else {
      await blockUser(currentUserId, otherUserId);
    }
    isBlocked.value = !isBlocked.value;
  }
}

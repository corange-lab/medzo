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

  var blockedUsersRef = FirebaseFirestore.instance.collection('blocked_users');

  ProfileController(this.uId);

  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  AllUserController allUserController = Get.find<AllUserController>();

  // fetch the UserModel value from dataSnapShot
  Rx<UserModel> get user => _user;
  Rx<UserModel> _user = UserModel.newUser().obs;

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

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

  Future<void> blockUser({
    required String currentUserID,
    required String blockedUserID,
  }) async {
    // Add the blocked user to the blocked_users collection
    await blockedUsersRef.doc(currentUserID).set({
      'blockedUserId': blockedUserID,
    });
    toast(message: 'blocked!');
  }

  Future<void> unblockUser({
    required String currentUserID,
    required String blockedUserID,
  }) async {
    // Remove the blocked user from the blocked_users collection
    await blockedUsersRef.doc(currentUserID).delete();
    toast(message: 'unblocked!');
  }

  Future<bool> isUserBlocked({
    required String currentUserID,
    required String otherUserID,
  }) async {
    // Check if the other user is in the blocked_users collection
    DocumentSnapshot doc = await blockedUsersRef.doc(currentUserID).get();

    // Return true if the other user is blocked, false otherwise
    return doc.exists && doc['blockedUserId'] == otherUserID;
  }

  Stream<String> getUserBlockedStream({
    required String currentUserID,
    required String otherUserID,
  }) async* {
    while (true) {
      await Future.delayed(
          Duration(seconds: 2)); // Adjust the interval as needed

      try {
        // Check if the other user is in the blocked_users collection
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('blocked_users')
            .doc(currentUserID)
            .get();

        // Yield true if the other user is blocked, false otherwise
        yield doc.exists && doc['blockedUserId'] == otherUserID
            ? "blocked"
            : "unblocked";
      } catch (e) {
        // Handle errors if needed
        print('Error checking block status: $e');
        yield "unblocked"; // Return false in case of an error
      }
    }
  }

  Stream<bool> isUserBlockedStream({
    required String currentUserID,
    required String otherUserID,
  }) async* {
    while (true) {
      await Future.delayed(
          Duration(seconds: 2)); // Adjust the interval as needed

      try {
        // Check if the other user is in the blocked_users collection
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('blocked_users')
            .doc(currentUserID)
            .get();

        // Yield true if the other user is blocked, false otherwise
        yield doc.exists && doc['blockedUserId'] == otherUserID;
      } catch (e) {
        // Handle errors if needed
        print('Error checking block status: $e');
        yield false; // Return false in case of an error
      }
    }
  }
}

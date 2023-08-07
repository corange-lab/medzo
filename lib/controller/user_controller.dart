import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/model/user_relationship.dart';

class UserController extends GetxController {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // AppStorage appStorage = AppStorage();

  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  User? get firebaseUser => FirebaseAuth.instance.currentUser;

  // current logged in user detail from users collection from firestore database
  Rx<UserModel> loggedInUser = UserModel().obs;

  @override
  void onInit() {
    log('UserController onInit');
    Get.lazyPut(() => AllUserController(), fenix: true);
    super.onInit();
    AllUserController allUserController = Get.find<AllUserController>();
    // allUserController.fetchAllUser();
    fetchUser();
  }

  // fetch current logged in user detail using currentUser.uid from users collection from firestore database
  Future<void> fetchUser(
      {void Function(UserModel userModel)? onSuccess}) async {
    try {
      UserRepository.instance
          .streamUser(currentUserId!)
          .listen((updatedUserData) {
        print('updatedUserData ${updatedUserData.name}');
        loggedInUser.value = updatedUserData;
        if (onSuccess != null) {
          onSuccess(updatedUserData);
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<UserRelationship>> streamFollowers(String userId) {
    CollectionReference<Map<String, dynamic>> followersRefCol =
        FirebaseFirestore.instance.collection('followers');
    final followersRef =
        followersRefCol.doc(userId).collection('user_followers');

    return followersRef.snapshots().map((followersSnapshot) {
      return parseFollowers(followersSnapshot);
    });
  }

  Stream<List<UserRelationship>> streamFollowing(String userId) {
    CollectionReference<Map<String, dynamic>> followingRefCol =
        FirebaseFirestore.instance.collection('following');
    final followingRef =
        followingRefCol.doc(userId).collection('user_following');

    return followingRef.snapshots().map((followingSnapshot) {
      return parseFollowing(followingSnapshot);
    });
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

  /* // Stream of followers
  Stream<List<UserRelationship>> followersStream =
      userService.streamFollowers('user_id');

  // Stream of following
  Stream<List<UserRelationship>> followingStream =
      userService.streamFollowing('user_id');

  // Listen to changes in the streams
  followersStream.listen((followers) {
    followers.forEach((follower) {
      print('Follower: ${follower.userId}, Timestamp: ${follower.timestamp}');
    });
  });

  followingStream.listen((following) {
    following.forEach((followedUser) {
      print('Following: ${followedUser.userId}, Timestamp: ${followedUser.timestamp}');
    });
  });*/
}

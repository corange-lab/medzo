import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/controller/user_controller.dart';
import 'package:medzo/model/comment_data.dart';
import 'package:medzo/model/post_model.dart';
import 'package:medzo/model/user_model.dart';

class PostController extends GetxController {
  RxList<File> selectedMultiImages = <File>[].obs;
  RxList<PostData> allPost = <PostData>[].obs;

  RxList<bool> isSaveMedicine = List.filled(5, false).obs;

  var pageController = PageController().obs;
  RxInt pageIndex = 0.obs;

  String loggedInUserId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference postRef =
      FirebaseFirestore.instance.collection('posts');

  final CollectionReference favouritesRef =
      FirebaseFirestore.instance.collection('favourites');

  AllUserController allUserController = Get.find<AllUserController>();
  UserController userController = Get.find<UserController>();

  TextEditingController commentController = TextEditingController();

  final FocusNode commentFocusNode = FocusNode();

  CommentData? replyingCommentData;
  UserModel? replyingCommentUser;

  PostData? currentPostData;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // fetchAllPosts();
  // }

  Stream<QuerySnapshot<Object?>> fetchAllPosts() {
    return postRef
        .where('creatorId', isNotEqualTo: null)
        .orderBy('createdTime', descending: true)
        .get()
        .asStream();
  }

  Stream<QuerySnapshot<Object?>> fetchDashboardPosts() {
    return postRef
        .where('creatorId', isNotEqualTo: null)
        .orderBy('createdTime', descending: true)
        .limit(4)
        .get()
        .asStream();
  }

  Stream<QuerySnapshot<Object?>> streamUserPosts(String userId) {
    return postRef
        .where('creatorId', isEqualTo: userId, isNotEqualTo: null)
        .orderBy('createdTime', descending: true)
        .snapshots();
  }

  UserModel findUser(String userId) {
    return allUserController.findSingleUserFromAllUser(userId);
  }

  // check whether my PostData has been liked by current user or not
  bool hasLikedThisComment(CommentData commentData) {
    if (commentData.likedUsers != null && commentData.likedUsers!.isNotEmpty) {
      return commentData.likedUsers!
          .contains(userController.loggedInUser.value.id);
    }
    return false;
  }

  Future<void> addLikeOnComment(PostData postData, String commentId) async {
    // alter existing comment and add new comment

    CommentData? commentData = (postData.postComments ?? [])
        .toList()
        .firstWhereOrNull((element) => element.id == commentId);
    if (commentData?.likedUsers != null &&
        commentData!.likedUsers!.isNotEmpty) {
      if (commentData.likedUsers!
          .contains(userController.loggedInUser.value.id)) {
        commentData.likedUsers!.remove(userController.loggedInUser.value.id);
      } else {
        commentData.likedUsers!.add(userController.loggedInUser.value.id);
      }
    } else {
      commentData?.likedUsers = [];
      commentData?.likedUsers?.add(userController.loggedInUser.value.id);
    }

    update([postData.id ?? 'post${postData.id}']);
    return postRef
        .doc(postData.id)
        .set(postData.toFirebaseMap(), SetOptions(merge: true));
  }

  // check whether my PostData has been liked by current user or not
  bool isLiked(PostData postData) {
    if (postData.likedUsers != null && postData.likedUsers!.isNotEmpty) {
      return postData.likedUsers!
          .contains(userController.loggedInUser.value.id);
    }
    return false;
  }

  Future<void> addLike(PostData postData) async {
    // alter existing comment and add new comment

    if (postData.likedUsers != null && postData.likedUsers!.isNotEmpty) {
      if (postData.likedUsers!.contains(userController.loggedInUser.value.id)) {
        postData.likedUsers!.remove(userController.loggedInUser.value.id);
      } else {
        postData.likedUsers!.add(userController.loggedInUser.value.id);
      }
    } else {
      postData.likedUsers = [];
      postData.likedUsers?.add(userController.loggedInUser.value.id);
    }

    // add comment to current postData
    update([postData.id ?? 'post${postData.id}']);
    return postRef
        .doc(postData.id)
        .set(postData.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<PostData?> addComment() async {
    var value = await postRef.doc(currentPostData!.id).get();
    if (value.data() == null) {
      return null;
    }
    currentPostData = PostData.fromMap(value.data()! as Map<String, dynamic>);

    String commentId = postRef.doc().id;
    // alter existing comment and add new comment
    currentPostData = currentPostData!.copyWith(postComments: [
      ...currentPostData!.postComments ?? [],
      CommentData(
          id: commentId,
          content: commentController.text.trim(),
          commentUserId: userController.loggedInUser.value.id,
          createdTime: DateTime.now())
    ]);

    // clear comment controller
    commentController.clear();
    await postRef
        .doc(currentPostData!.id)
        .set(currentPostData!.toFirebaseMap(), SetOptions(merge: true));
    return currentPostData!;
  }

  // add Comment Of Comment as similar to add comment in the post. CommentData will have a comments
  Future<PostData?> addCommentOfComment(CommentData commentData) async {
    // same as above add Comment Of Comment as similar to add comment in the post. CommentData will have a comments

    var value = await postRef.doc(currentPostData!.id).get();
    if (value.data() == null) {
      return null;
    }
    currentPostData = PostData.fromMap(value.data()! as Map<String, dynamic>);

    String commentId = postRef.doc().id;
    // alter existing comment and add new comment
    commentData = commentData.copyWith(commentComments: [
      ...commentData.commentComments ?? [],
      CommentData(
          id: commentId,
          content: commentController.text.trim(),
          commentUserId: userController.loggedInUser.value.id,
          createdTime: DateTime.now())
    ]);

    // update commentData into the postData
    // postData = postData
    //     .copyWith(postComments: [...postData.postComments ?? [], commentData]);
    if (currentPostData!.postComments == null) {
      currentPostData!.postComments = [];
    }
    int index = currentPostData!.postComments!
        .indexWhere((element) => element.id == commentData.id);
    currentPostData!.postComments![index] = commentData;
    // clear comment controller
    commentController.clear();
    await postRef
        .doc(currentPostData!.id)
        .set(currentPostData!.toFirebaseMap(), SetOptions(merge: true));
    return currentPostData!;
  }

  bool hasLikedThisCommentOfComment(commentData) {
    if (commentData.likedUsers != null && commentData.likedUsers!.isNotEmpty) {
      return commentData.likedUsers!
          .contains(userController.loggedInUser.value.id);
    }
    return false;
  }

  Future<void> addLikeOnCommentOfComment(CommentData parentCommentData,
      CommentData childCommentData, String commentId) async {
    // alter existing comment and add new comment

    CommentData? commentData = (parentCommentData.commentComments ?? [])
        .toList()
        .firstWhereOrNull((element) => element.id == commentId);
    if (commentData?.likedUsers != null &&
        commentData!.likedUsers!.isNotEmpty) {
      if (commentData.likedUsers!
          .contains(userController.loggedInUser.value.id)) {
        commentData.likedUsers!.remove(userController.loggedInUser.value.id);
      } else {
        commentData.likedUsers!.add(userController.loggedInUser.value.id);
      }
    } else {
      commentData?.likedUsers = [];
      commentData?.likedUsers?.add(userController.loggedInUser.value.id);
    }

    update([currentPostData!.id ?? 'post${currentPostData!.id}']);
    return postRef
        .doc(currentPostData!.id)
        .set(currentPostData!.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<void> deleteCommentOfComment(CommentData parentCommentData,
      CommentData childCommentData, String commentId) async {
    CommentData? commentData = (parentCommentData.commentComments ?? [])
        .toList()
        .firstWhereOrNull((element) => element.id == commentId);

    if (commentData != null) {
      parentCommentData.commentComments!.remove(commentData);
    }

    update([currentPostData!.id ?? 'post${currentPostData!.id}']);
    return postRef
        .doc(currentPostData!.id)
        .set(currentPostData!.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<void> deleteComment(PostData postData, CommentData commentData) {
    postData.postComments!.remove(commentData);
    update([postData.id ?? 'post${postData.id}']);
    return postRef
        .doc(postData.id)
        .set(postData.toFirebaseMap(), SetOptions(merge: true));
  }

  bool replyActionEnabled() {
    return (replyingCommentUser != null && replyingCommentData != null);
  }
}

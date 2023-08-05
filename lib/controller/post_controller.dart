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

  @override
  void onInit() {
    super.onInit();
    fetchAllPosts();
  }

  Stream<QuerySnapshot<Object?>> fetchAllPosts() {
    return postRef.where('creatorId', isNull: false).get().asStream();
  }

  //TODO; fetch favourite post of logged in user
  Stream<QuerySnapshot<Object?>> fetchFavouritePosts() {
    return favouritesRef.get().asStream().where((event) =>
        event.docs.where((element) => element.id == loggedInUserId).isNotEmpty);
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
    return postRef.doc(postData.id).update(postData.toFirebaseMap());
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
    return postRef.doc(postData.id).update(postData.toFirebaseMap());
  }

  Future<PostData> addComment(PostData postData) async {
    String commentId = postRef.doc().id;
    // alter existing comment and add new comment
    postData = postData.copyWith(postComments: [
      ...postData.postComments ?? [],
      CommentData(
          id: commentId,
          content: commentController.text.trim(),
          commentUserId: userController.loggedInUser.value.id,
          createdTime: DateTime.now())
    ]);

    // add comment to current postData

    // clear comment controller
    commentController.clear();
    await postRef.doc(postData.id).update(postData.toFirebaseMap());
    return postData;
  }

  // add Comment Of Comment as similar to add comment in the post. CommentData will have a comments
  Future<PostData> addCommentOfComment(
      PostData postData, CommentData commentData) async {
    // same as above add Comment Of Comment as similar to add comment in the post. CommentData will have a comments

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
    if (postData.postComments == null) {
      postData.postComments = [];
    }
    int index = postData.postComments!
        .indexWhere((element) => element.id == commentData.id);
    postData.postComments![index] = commentData;
    // clear comment controller
    commentController.clear();
    await postRef.doc(postData.id).update(postData.toFirebaseMap());
    return postData;
  }

  bool hasLikedThisCommentOfComment(commentData) {
    if (commentData.likedUsers != null && commentData.likedUsers!.isNotEmpty) {
      return commentData.likedUsers!
          .contains(userController.loggedInUser.value.id);
    }
    return false;
  }

  Future<void> addLikeOnCommentOfComment(PostData postData,
      CommentData parentCommentData, String commentId) async {
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

    update([postData.id ?? 'post${postData.id}']);
    return postRef.doc(postData.id).update(postData.toFirebaseMap());
  }
}

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/controller/user_controller.dart';
import 'package:medzo/model/comment_data.dart';
import 'package:medzo/model/post_model.dart';
import 'package:medzo/model/report_data.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/widgets/dialogue.dart';
import 'package:url_launcher/url_launcher.dart';

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
        .limit(30)
        .get()
        .asStream();
  }

  Stream<QuerySnapshot<Object?>> streamUserPosts(String userId) {
    return postRef
        .where('creatorId', isEqualTo: userId, isNotEqualTo: null)
        .orderBy('createdTime', descending: true)
        .snapshots();
  }

  deletePost(BuildContext context, String postId) {
    postRef.doc(postId).delete().then((value) {
      Get.back();
      showDialog(
        context: context,
        builder: (context) {
          return successDialogue(
            titleText: "Successful Deleted",
            subtitle: "Your post has been Deleted successfully.",
            iconDialogue: SvgIcon.check_circle,
            btntext: "Okay",
            onPressed: () {
              update();
              Get.back();
            },
          );
        },
      );
    }).catchError((onError) {
      print('Error deleting document: $onError');
    });
  }

  Future reportPost(
      BuildContext context, PostData postData, String reason) async {
    return addReport(postData, reason).then((value) {
      Get.back();
      showDialog(
        context: context,
        builder: (context) {
          return successDialogue(
            titleText: "Successfully Reported",
            subtitle: "Post has been Reported successfully.",
            iconDialogue: SvgIcon.check_circle,
            btntext: "Okay",
            onPressed: () {
              update();
              Get.back();
            },
          );
        },
      );
    }).catchError((onError) {
      print('Error reporting document: $onError');
    });
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

  // check whether my PostData has been reported by current user or not
  bool hasReportedThisComment(CommentData commentData) {
    if (commentData.reportDataList != null &&
        commentData.reportDataList!.isNotEmpty) {
      return commentData.reportDataList! // TODO: change logic
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

  Future<void> addReportOnComment(
      PostData postData, String commentId, String reason) async {
    // alter existing comment and add new comment

    CommentData? commentData = (postData.postComments ?? [])
        .toList()
        .firstWhereOrNull((element) => element.id == commentId);
    if (commentData?.reportDataList != null &&
        commentData!.reportDataList!.isNotEmpty) {
      if ((commentData.reportDataList ?? []).toList().firstWhereOrNull(
              (element) =>
                  element.userId == userController.loggedInUser.value.id) !=
          null) {
        print('already reported 3');
        commentData.reportDataList!.removeWhere((element) =>
            element.userId == userController.loggedInUser.value.id);
        commentData.reportDataList!.add(ReportData(
            userId: userController.loggedInUser.value.id!, reason: reason));
      } else {
        commentData.reportDataList!.add(ReportData(
            userId: userController.loggedInUser.value.id!, reason: reason));
      }
    } else {
      commentData?.reportDataList = [];
      commentData?.reportDataList?.add(ReportData(
          userId: userController.loggedInUser.value.id!, reason: reason));
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

  // check whether my PostData has been Report by current user or not
  bool isReported(PostData postData) {
    if (postData.reportDataList != null &&
        postData.reportDataList!.isNotEmpty) {
      return postData.reportDataList!
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

  // Future<void> addReport(PostData postData, String reason) async {
  //   // alter existing comment and add new comment
  //
  //   if (postData.reportDataList != null &&
  //       postData.reportDataList!.isNotEmpty) {
  //     if ((postData.reportDataList ?? []).toList().firstWhereOrNull((element) =>
  //             element.userId == userController.loggedInUser.value.id) !=
  //         null) {
  //       // postData.reportDataList!.removeWhere((element) =>
  //       //     element.userId == userController.loggedInUser.value.id);
  //       postData.reportDataList?.add(ReportData(
  //           userId: userController.loggedInUser.value.id!, reason: reason));
  //     } else {
  //       postData.reportDataList!.add(ReportData(
  //           userId: userController.loggedInUser.value.id!, reason: reason));
  //     }
  //   } else {
  //     postData.reportDataList = [];
  //     postData.reportDataList?.add(ReportData(
  //         userId: userController.loggedInUser.value.id!, reason: reason));
  //   }
  //
  //   // add comment to current postData
  //   await postRef
  //       .doc(postData.id)
  //       .set(postData.toFirebaseMap(), SetOptions(merge: true));
  //
  //   if (postData.reportDataList!.length > 9) {
  //     try {
  //       await postRef.doc(postData.id).delete();
  //       print('Post deleted due to excessive reports');
  //     } catch (e) {
  //       print('Error deleting post: $e');
  //     }
  //   }
  //   update([postData.id ?? 'post${postData.id}']);
  // }

  Future<void> addReport(PostData postData, String reason) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    String? postId = postData.id;

    if (userId == null || postId == null) {
      print('User ID or Post ID is null');
      return;
    }

    postData.reportDataList ??= [];

    bool alreadyReported =
        postData.reportDataList!.any((report) => report.userId == userId);

    if (!alreadyReported) {
      postData.reportDataList?.add(ReportData(userId: userId, reason: reason));
      await postRef
          .doc(postId)
          .set(postData.toFirebaseMap(), SetOptions(merge: true));
    } else {
      toast(message: "Post Already Reported!");
    }

    if (postData.reportDataList!.length > 9) {
      try {
        await postRef.doc(postId).delete();
        sendUserPostReportEmail(userId);
        print('Post deleted due to excessive reports');
      } catch (e) {
        print('Error deleting post: $e');
      }
    }

    update([postId]);
  }

  Future<void> sendUserPostReportEmail(String recepientEmail) async {
    final smtpServer = gmail('savaliyakevin171@gmail.com', 'ujsorydlhlgjtndu');

    final message = Message()
      ..from = Address('savaliyakevin171@gmail.com', 'Medzo')
      ..recipients.add(recepientEmail)
      ..subject = 'Post Removal Notification'
      ..text = '''Hello,

We hope this message finds you well. We are writing to inform you that one of your posts has been removed from our platform. This action was taken because the post in question received reports from more than 10 users for containing explicit language, hate speech, and other forms of prohibited content on your profile.

Our community is our top priority, and we are committed to maintaining a safe and respectful environment for all users. As such, we strictly enforce our guidelines against hate speech and explicit content.

We understand that this may be disappointing, but we encourage you to review our community guidelines to ensure your future posts align with our standards.

If you have any questions or concerns about this action, or if you believe this removal was in error, please don't hesitate to reach out to us at themedzoteam@gmail.com.. We're here to assist you and address any issues you may have.

Thank you for your understanding and cooperation.

Best regards,
Medzo Support Team''';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending email: $e');
    }
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

  bool hasLikedThisCommentOfComment(CommentData commentData) {
    if (commentData.upvoteUsers != null &&
        commentData.upvoteUsers!.isNotEmpty) {
      return commentData.upvoteUsers!
          .contains(userController.loggedInUser.value.id);
    }
    return false;
  }

  bool hasReportedThisCommentOfComment(CommentData commentData) {
    if (commentData.reportDataList != null &&
        commentData.reportDataList!.isNotEmpty) {
      return commentData.reportDataList!.firstWhereOrNull((element) =>
              element.userId == userController.loggedInUser.value.id) !=
          null;
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

  Future<void> addReportOnCommentOfComment(CommentData parentCommentData,
      CommentData childCommentData, String commentId, String reason) async {
    // alter existing comment and add new comment

    CommentData? commentData = (parentCommentData.commentComments ?? [])
        .toList()
        .firstWhereOrNull((element) => element.id == commentId);
    if (commentData?.reportDataList != null &&
        commentData!.reportDataList!.isNotEmpty) {
      if ((commentData.reportDataList ?? []).toList().firstWhereOrNull(
              (element) =>
                  element.userId == userController.loggedInUser.value.id) !=
          null) {
        print('already reported 2');
        commentData.reportDataList!.removeWhere((element) =>
            element.userId == userController.loggedInUser.value.id);
        commentData.reportDataList?.add(ReportData(
            userId: userController.loggedInUser.value.id!, reason: reason));
      } else {
        commentData.reportDataList?.add(ReportData(
            userId: userController.loggedInUser.value.id!, reason: reason));
      }
    } else {
      commentData?.reportDataList = [];
      commentData?.reportDataList?.add(ReportData(
          userId: userController.loggedInUser.value.id!, reason: reason));
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

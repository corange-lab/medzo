import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/model/post_model.dart';

class PostController extends GetxController {
  RxList<File> selectedMultiImages = <File>[].obs;
  RxList<PostData> allPost = <PostData>[].obs;

  RxList<bool> isSaveMedicine = List.filled(5, false).obs;
  RxList<bool> isSaveExpert = List.filled(4, false).obs;
  var pageController = PageController().obs;
  RxInt pageIndex = 0.obs;

  String loggedInUserId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference postRef =
      FirebaseFirestore.instance.collection('posts');

  @override
  void onInit() {
    super.onInit();
    fetchAllPosts();
  }

  Stream<QuerySnapshot<Object?>> fetchAllPosts() {
    return postRef
        .doc(loggedInUserId)
        .collection("postImages")
        .get()
        .asStream();
  }
}
